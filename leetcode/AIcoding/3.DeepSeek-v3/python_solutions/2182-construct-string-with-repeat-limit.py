class Solution:
    def repeatLimitedString(self, s: str, repeatLimit: int) -> str:
        freq = [0] * 26
        for c in s:
            freq[ord(c) - ord('a')] += 1

        res = []
        i = 25
        while i >= 0:
            if freq[i] == 0:
                i -= 1
                continue
            count = 0
            while freq[i] > 0 and count < repeatLimit:
                res.append(chr(i + ord('a')))
                freq[i] -= 1
                count += 1
            if freq[i] > 0:
                found = False
                for j in range(i - 1, -1, -1):
                    if freq[j] > 0:
                        res.append(chr(j + ord('a')))
                        freq[j] -= 1
                        found = True
                        break
                if not found:
                    break
        return ''.join(res)