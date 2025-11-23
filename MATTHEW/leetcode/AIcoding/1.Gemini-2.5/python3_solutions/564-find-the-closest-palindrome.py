class Solution:
    def nearestPalindromic(self, n: str) -> str:
        L = len(n)
        N = int(n)

        def build_palindrome(left_half_str, target_length):
            if target_length % 2 == 0:
                right_half = left_half_str[::-1]
            else:
                right_half = left_half_str[:-1][::-1]
            return int(left_half_str + right_half)

        candidates = set()

        # Candidate 1: Palindrome of length L-1 (all 9s, e.g., 9, 99, 999)
        if L > 1:
            candidates.add(10**(L - 1) - 1)

        # Candidate 2: Palindrome of length L+1 (1 followed by L-1 zeros, then 1, e.g., 11, 101, 1001)
        candidates.add(10**L + 1)

        # Candidate 3: Palindromes derived from the first half of n, and its neighbors
        half_len = (L + 1) // 2
        prefix = n[:half_len]
        prefix_val = int(prefix)

        for delta in [-1, 0, 1]:
            new_prefix_val = prefix_val + delta

            # Handle special case for 0 (e.g., n="1", prefix="1", delta=-1 -> 0)
            if new_prefix_val <= 0:
                if new_prefix_val == 0: # Only 0 is a valid palindrome
                    candidates.add(0)
                continue

            new_prefix_str = str(new_prefix_val)

            current_len_of_prefix = len(new_prefix_str)

            if current_len_of_prefix == half_len:
                # Resulting palindrome has length L
                pal = build_palindrome(new_prefix_str, L)
                candidates.add(pal)
            elif current_len_of_prefix == half_len - 1:
                # Resulting palindrome has length L-1 (e.g., "100" -> "99")
                pal = build_palindrome(new_prefix_str, L - 1)
                candidates.add(pal)
            elif current_len_of_prefix == half_len + 1:
                # Resulting palindrome has length L+1 (e.g., "99" -> "101")
                pal = build_palindrome(new_prefix_str, L + 1)
                candidates.add(pal)

        min_diff = float('inf')
        result = -1

        for cand in candidates:
            if cand == N:
                continue

            diff = abs(cand - N)
            if diff < min_diff:
                min_diff = diff
                result = cand
            elif diff == min_diff:
                result = min(result, cand)

        return str(result)