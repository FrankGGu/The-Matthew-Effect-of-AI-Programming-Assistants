class Solution:
    def sortString(self, s: str) -> str:
        counts = [0] * 26
        for char in s:
            counts[ord(char) - ord('a')] += 1

        result = ""
        while len(result) < len(s):
            for i in range(26):
                if counts[i] > 0:
                    result += chr(ord('a') + i)
                    counts[i] -= 1

            for i in range(25, -1, -1):
                if counts[i] > 0:
                    result += chr(ord('a') + i)
                    counts[i] -= 1

        return result