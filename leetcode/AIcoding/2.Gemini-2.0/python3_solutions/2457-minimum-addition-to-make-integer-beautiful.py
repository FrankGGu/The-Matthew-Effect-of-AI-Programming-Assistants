class Solution:
    def makeIntegerBeautiful(self, n: int, target: int) -> int:
        s = str(n)
        if sum(int(d) for d in s) <= target:
            return 0

        length = len(s)
        for i in range(length - 1, -1, -1):
            if sum(int(d) for d in str(n)) <= target:
                return n - int(s)

            pow10 = 10 ** (length - 1 - i)
            add = pow10 - (n % pow10)
            n += add
            s = str(n)
            length = len(s)

        return int(s) - int(str(int(s)))