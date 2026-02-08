import collections
import bisect

class Solution:
    def longestSpecialSubstring(self, s: str) -> int:
        char_runs = collections.defaultdict(list)

        if not s:
            return 0

        curr_char = s[0]
        curr_len = 0
        for char in s:
            if char == curr_char:
                curr_len += 1
            else:
                char_runs[curr_char].append(curr_len)
                curr_char = char
                curr_len = 1
        char_runs[curr_char].append(curr_len)

        overall_max_k = 0

        for char_code in range(ord('a'), ord('z') + 1):
            c = chr(char_code)
            if c not in char_runs:
                continue

            Ls = char_runs[c]
            Ls.sort() # Sort in ascending order

            # Compute prefix sums for Ls
            prefix_sums = [0] * (len(Ls) + 1)
            for i in range(len(Ls)):
                prefix_sums[i+1] = prefix_sums[i] + Ls[i]

            low = 1
            high = Ls[-1] # Max possible length for this character
            max_k_for_char = 0

            while low <= high:
                mid = (low + high) // 2

                # Find count of runs with length >= mid
                # bisect_left finds the insertion point for mid in Ls
                # All elements from idx onwards are >= mid
                idx = bisect.bisect_left(Ls, mid)
                count_ge_mid = len(Ls) - idx

                # Sum of lengths for runs with length >= mid
                # This is prefix_sums[len(Ls)] - prefix_sums[idx]
                sum_ge_mid = prefix_sums[len(Ls)] - prefix_sums[idx]

                # Calculate total occurrences of special substring of length 'mid'
                # Each run of length L contributes (L - mid + 1) occurrences
                # Sum(L - mid + 1) for L >= mid
                # = Sum(L) - Sum(mid - 1)
                # = sum_ge_mid - count_ge_mid * (mid - 1)
                total_occurrences = sum_ge_mid - count_ge_mid * (mid - 1)

                if total_occurrences >= 3:
                    max_k_for_char = mid
                    low = mid + 1
                else:
                    high = mid - 1

            overall_max_k = max(overall_max_k, max_k_for_char)

        return overall_max_k