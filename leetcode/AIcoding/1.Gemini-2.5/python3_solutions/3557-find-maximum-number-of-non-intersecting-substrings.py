class Solution:
    def findMaximumNumberofNonIntersectingSubstrings(self, s: str) -> list[str]:
        n = len(s)

        first = [-1] * 26
        last = [-1] * 26

        for i in range(n):
            char_idx = ord(s[i]) - ord('a')
            if first[char_idx] == -1:
                first[char_idx] = i
            last[char_idx] = i

        valid_intervals = []
        for i in range(n):
            char_idx_i = ord(s[i]) - ord('a')

            if i == first[char_idx_i]:
                current_left = i
                current_right = last[char_idx_i]
                is_valid_start = True

                k = i
                while k <= current_right:
                    char_idx_k = ord(s[k]) - ord('a')

                    if first[char_idx_k] < current_left:
                        is_valid_start = False
                        break

                    current_right = max(current_right, last[char_idx_k])
                    k += 1

                if is_valid_start:
                    valid_intervals.append((current_left, current_right))

        valid_intervals.sort(key=lambda x: (x[1], x[1] - x[0] + 1))

        result_substrings = []
        last_end_time = -1

        for start, end in valid_intervals:
            if start > last_end_time:
                result_substrings.append(s[start : end + 1])
                last_end_time = end

        return result_substrings