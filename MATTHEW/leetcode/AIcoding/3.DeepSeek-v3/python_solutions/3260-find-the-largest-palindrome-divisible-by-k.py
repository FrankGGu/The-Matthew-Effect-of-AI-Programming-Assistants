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
            for i in range(upper, lower - 1, -1):
                if i * i < pal:
                    break
                if pal % i == 0:
                    found = True
                    return pal % 1337
            half -= 1