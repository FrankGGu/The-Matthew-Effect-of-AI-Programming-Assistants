class Solution:
    def minFlips(self, s: str) -> int:
        n = len(s)
        s = s + s
        alt0 = ""
        alt1 = ""
        for i in range(2 * n):
            if i % 2 == 0:
                alt0 += "0"
                alt1 += "1"
            else:
                alt0 += "1"
                alt1 += "0"

        ans = float('inf')

        flips0 = 0
        flips1 = 0

        for i in range(2 * n):
            if s[i] != alt0[i]:
                flips0 += 1
            if s[i] != alt1[i]:
                flips1 += 1

            if i >= n:
                if s[i - n] != alt0[i - n]:
                    flips0 -= 1
                if s[i - n] != alt1[i - n]:
                    flips1 -= 1

            if i >= n - 1:
                ans = min(ans, flips0, flips1)

        return ans