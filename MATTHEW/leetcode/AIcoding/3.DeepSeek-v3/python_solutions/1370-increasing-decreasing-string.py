class Solution:
    def sortString(self, s: str) -> str:
        freq = [0] * 26
        for c in s:
            freq[ord(c) - ord('a')] += 1

        res = []
        while len(res) < len(s):
            for i in range(26):
                if freq[i] > 0:
                    res.append(chr(i + ord('a')))
                    freq[i] -= 1
            for i in range(25, -1, -1):
                if freq[i] > 0:
                    res.append(chr(i + ord('a')))
                    freq[i] -= 1
        return ''.join(res)