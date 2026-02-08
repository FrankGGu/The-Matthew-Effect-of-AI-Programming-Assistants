class Solution:
    def maximumScore(self, a: int, b: int, c: int) -> int:
        stones = [a, b, c]
        stones.sort()
        score = 0

        while stones[1] > 0:
            score += 1
            stones[1] -= 1
            stones[2] -= 1
            stones.sort()

        return score