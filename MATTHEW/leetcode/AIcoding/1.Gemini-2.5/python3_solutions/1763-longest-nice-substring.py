class Solution:
    def longestNiceSubstring(self, s: str) -> str:

        def find_longest_recursive(current_s: str) -> str:
            n = len(current_s)
            if n < 2:
                return ""

            char_set = set(current_s)

            breaking_idx = -1
            for i in range(n):
                char = current_s[i]
                if (char.lower() not in char_set) or \
                   (char.upper() not in char_set):
                    breaking_idx = i
                    break

            if breaking_idx == -1:
                return current_s

            left_result = find_longest_recursive(current_s[:breaking_idx])
            right_result = find_longest_recursive(current_s[breaking_idx+1:])

            if len(left_result) >= len(right_result):
                return left_result
            else:
                return right_result

        return find_longest_recursive(s)