class Solution:
    def minElements(self, nums: List[int], limit: int, goal: int) -> int:
        total = sum(nums)
        diff = abs(goal - total)
        return (diff + limit - 1) // limit