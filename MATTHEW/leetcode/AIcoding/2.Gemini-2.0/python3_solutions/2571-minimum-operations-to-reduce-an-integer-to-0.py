class Solution:
    def minOperations(self, n: int) -> int:
        ans = 0
        while n > 0:
            if n % 2 == 0:
                n //= 2
            else:
                if (n == 3) or ((n >> 1) % 2 == 0):
                    n -= 1
                else:
                    n += 1
            ans += 1
        return ans