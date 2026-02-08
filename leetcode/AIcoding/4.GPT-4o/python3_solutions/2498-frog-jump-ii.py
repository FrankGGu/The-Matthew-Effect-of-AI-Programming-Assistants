class Solution:
    def maxJump(self, stones: List[int]) -> int:
        stones.sort()
        max_jump = 0
        for i in range(1, len(stones)):
            max_jump = max(max_jump, stones[i] - stones[i - 1])
        return max_jump