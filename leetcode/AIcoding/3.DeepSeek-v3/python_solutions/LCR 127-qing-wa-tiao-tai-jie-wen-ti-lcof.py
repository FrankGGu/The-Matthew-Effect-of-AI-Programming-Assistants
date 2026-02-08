class Solution:
    def trainWays(self, num: int) -> int:
        if num == 0:
            return 1
        if num == 1:
            return 1
        a, b = 1, 1
        for _ in range(2, num + 1):
            a, b = b, (a + b) % 1000000007
        return b