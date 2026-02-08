class Solution:
    def findTheString(self, lcp: List[List[int]]) -> str:
        n = len(lcp)
        result = ""
        chars_used = 0
        char_map = {}

        for i in range(n):
            if i not in char_map:
                result += chr(ord('a') + chars_used)
                char_map[i] = chars_used
                chars_used += 1
            else:
                result += chr(ord('a') + char_map[i])

        for i in range(n):
            for j in range(n):
                expected_lcp = 0
                if result[i] == result[j]:
                    if i + 1 < n and j + 1 < n:
                        expected_lcp = lcp[i+1][j+1] + 1
                    else:
                        expected_lcp = 1
                else:
                    expected_lcp = 0

                if lcp[i][j] != expected_lcp:
                    return ""

        return result