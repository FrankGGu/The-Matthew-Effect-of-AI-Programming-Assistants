class Solution:
    def getKth(self, lo: int, hi: int, k: int) -> int:
        def power(n):
            count = 0
            while n != 1:
                if n % 2 == 0:
                    n //= 2
                else:
                    n = 3 * n + 1
                count += 1
            return count

        powers = []
        for i in range(lo, hi + 1):
            powers.append((i, power(i)))

        powers.sort(key=lambda x: x[1])
        return powers[k - 1][0]