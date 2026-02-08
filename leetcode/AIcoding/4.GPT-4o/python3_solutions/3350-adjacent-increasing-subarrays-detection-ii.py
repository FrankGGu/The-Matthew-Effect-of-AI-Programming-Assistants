class Solution:
    def findSubarrays(self, nums: List[int]) -> bool:
        seen = set()
        for i in range(len(nums) - 1):
            current_sum = nums[i] + nums[i + 1]
            if current_sum in seen:
                return True
            seen.add(current_sum)
        return False