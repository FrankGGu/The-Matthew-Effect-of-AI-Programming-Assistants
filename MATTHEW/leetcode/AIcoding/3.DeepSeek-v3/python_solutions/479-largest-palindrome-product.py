class Solution:
    def largestPalindrome(self, n: int) -> int:
        if n == 1:
            return 9
        upper = 10 ** n - 1
        lower = 10 ** (n - 1)
        max_num = upper * upper
        half = max_num // (10 ** n)

        found = False
        pal = 0
        while not found:
            pal = int(str(half) + str(half)[::-1])
            for i in range(upper, int(pal ** 0.5) - 1, -1):
                if pal % i == 0 and pal // i <= upper:
                    found = True
                    break
            half -= 1

        return pal % 1337