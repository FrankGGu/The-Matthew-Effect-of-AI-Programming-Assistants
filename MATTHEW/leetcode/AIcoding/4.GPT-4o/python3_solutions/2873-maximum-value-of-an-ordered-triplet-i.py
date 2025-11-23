class Solution:
    def maximumTripletValue(self, nums: List[int]) -> int:
        max_value = 0
        n = len(nums)
        for j in range(1, n - 1):
            max_i = max(nums[:j])
            max_k = max(nums[j + 1:])
            max_value = max(max_value, max_i - nums[j] + max_k)
        return max_value