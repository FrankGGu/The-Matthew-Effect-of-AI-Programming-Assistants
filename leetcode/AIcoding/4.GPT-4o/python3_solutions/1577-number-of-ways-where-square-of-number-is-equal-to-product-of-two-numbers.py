class Solution:
    def numOfWays(self, n: int) -> int:
        count = 0
        for i in range(1, n + 1):
            for j in range(1, n + 1):
                if i * j == i ** 2:
                    count += 1
        return count