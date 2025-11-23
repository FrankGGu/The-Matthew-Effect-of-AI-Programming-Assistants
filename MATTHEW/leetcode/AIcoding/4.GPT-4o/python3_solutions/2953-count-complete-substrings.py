class Solution:
    def countCompleteSubstrings(self, s: str) -> int:
        n = len(s)
        total_count = 0

        for i in range(n):
            char_count = {}
            unique_count = 0

            for j in range(i, n):
                if s[j] not in char_count:
                    char_count[s[j]] = 0
                    unique_count += 1
                char_count[s[j]] += 1

                if unique_count == len(char_count):
                    total_count += 1

        return total_count