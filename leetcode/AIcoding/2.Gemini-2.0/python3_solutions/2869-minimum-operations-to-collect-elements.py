class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        count = 0
        seen = set()
        for i in range(len(nums) - 1, -1, -1):
            if nums[i] <= k and nums[i] not in seen:
                seen.add(nums[i])
            count += 1
            if len(seen) == k:
                return count
        return count