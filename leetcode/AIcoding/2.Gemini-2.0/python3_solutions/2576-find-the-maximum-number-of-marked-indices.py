class Solution:
    def maxNumOfMarkedIndices(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        left, right = 0, (n + 1) // 2
        count = 0
        while right < n:
            if 2 * nums[left] <= nums[right]:
                count += 1
                left += 1
                right += 1
            else:
                right += 1
        return 2 * count