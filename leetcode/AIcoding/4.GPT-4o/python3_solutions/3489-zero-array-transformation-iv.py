class Solution:
    def canTransform(self, nums: List[int]) -> bool:
        if sum(nums) % len(nums) != 0:
            return False

        target = sum(nums) // len(nums)
        return all(abs(num - target) <= 1 for num in nums)