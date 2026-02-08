class Solution:
    def atMostNGivenDigitSet(self, digits: List[str], n: int) -> int:
        s = str(n)
        k = len(s)
        m = len(digits)
        res = 0

        for i in range(1, k):
            res += m ** i

        for i in range(k):
            hasSamePrefix = False
            for d in digits:
                if d[0] < s[i]:
                    res += m ** (k - i - 1)
                elif d[0] == s[i]:
                    hasSamePrefix = True
            if not hasSamePrefix:
                return res

        return res + 1