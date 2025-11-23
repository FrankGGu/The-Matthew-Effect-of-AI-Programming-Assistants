class Solution:
    def distributeCandies(self, candies: int, limit: int) -> int:
        count = 0
        for c1 in range(limit + 1):
            for c2 in range(limit + 1):
                c3 = candies - c1 - c2
                if 0 <= c3 <= limit:
                    count += 1
        return count