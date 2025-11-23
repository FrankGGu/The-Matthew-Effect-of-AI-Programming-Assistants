class Solution:
    def sortString(self, s: str) -> str:
        counts = [0] * 26
        for char_code in s:
            counts[ord(char_code) - ord('a')] += 1

        result = []
        n = len(s)

        while len(result) < n:
            # Append characters in increasing order
            for i in range(26):
                if counts[i] > 0:
                    result.append(chr(ord('a') + i))
                    counts[i] -= 1

            # Append characters in decreasing order
            for i in range(25, -1, -1):
                if counts[i] > 0:
                    result.append(chr(ord('a') + i))
                    counts[i] -= 1

        return "".join(result)