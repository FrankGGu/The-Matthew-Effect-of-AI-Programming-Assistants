class Solution:
    def stoneGameVII(self, stones: List[int]) -> int:
        total = sum(stones)
        left_sum = 0
        right_sum = total
        max_score = 0

        for stone in stones:
            left_sum += stone
            right_sum -= stone
            max_score = max(max_score, abs(left_sum - right_sum))

        return max_score