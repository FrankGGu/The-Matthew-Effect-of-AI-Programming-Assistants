class Solution:
    def maxBalls(self, basket: str) -> int:
        from collections import Counter

        count = Counter(basket)
        max_balls = 0

        for key in count:
            max_balls = max(max_balls, count[key])

        return max_balls