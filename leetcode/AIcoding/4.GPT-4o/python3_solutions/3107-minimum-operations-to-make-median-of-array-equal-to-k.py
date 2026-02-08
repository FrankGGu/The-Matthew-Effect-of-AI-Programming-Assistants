class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        nums.sort()
        left, right = 0, len(nums) - 1
        operations = 0

        while left <= right:
            if nums[left] < k:
                operations += k - nums[left]
                left += 1
            elif nums[right] > k:
                operations += nums[right] - k
                right -= 1
            else:
                break

        return operations