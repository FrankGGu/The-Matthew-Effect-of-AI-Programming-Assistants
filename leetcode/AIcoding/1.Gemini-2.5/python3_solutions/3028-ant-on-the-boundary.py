class Solution:
    def returnToBoundaryCount(self, nums: list[int]) -> int:
        current_position = 0
        boundary_returns = 0
        for step in nums:
            current_position += step
            if current_position == 0:
                boundary_returns += 1
        return boundary_returns