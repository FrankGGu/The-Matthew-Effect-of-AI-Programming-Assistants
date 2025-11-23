class Solution:
    def maximumLength(self, s: str) -> int:
        from collections import defaultdict

        n = len(s)
        substrings = defaultdict(int)

        for i in range(n):
            current_char = s[i]
            length = 1
            for j in range(i + 1, n):
                if s[j] == current_char:
                    length += 1
                else:
                    break
            for l in range(1, length + 1):
                substrings[current_char * l] += 1

        max_len = -1
        for key in substrings:
            if substrings[key] >= 3:
                max_len = max(max_len, len(key))

        return max_len