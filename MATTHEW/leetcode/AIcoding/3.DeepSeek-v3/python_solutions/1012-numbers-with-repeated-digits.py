class Solution:
    def numDupDigitsAtMostN(self, n: int) -> int:
        s = str(n)
        length = len(s)
        res = 0

        # Count numbers with no repeated digits and less than length digits
        for i in range(1, length):
            res += 9 * self.perm(9, i - 1)

        # Count numbers with no repeated digits and equal to length digits
        seen = set()
        for i in range(length):
            num = int(s[i])
            for j in range(0 if i else 1, num):
                if j not in seen:
                    res += self.perm(9 - i, length - i - 1)
            if num in seen:
                break
            seen.add(num)
        else:
            res += 1

        return n - res

    def perm(self, m: int, k: int) -> int:
        if k == 0:
            return 1
        return self.perm(m, k - 1) * (m - k + 1)