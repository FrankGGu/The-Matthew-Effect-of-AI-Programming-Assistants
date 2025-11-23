class Solution:
    def addMinimum(self, word: str) -> int:
        res = 0
        expected = 'abc'
        i = 0
        n = len(word)
        ptr = 0

        while ptr < n:
            if word[ptr] == expected[i]:
                ptr += 1
            else:
                res += 1
            i = (i + 1) % 3

        res += (3 - i) % 3
        return res