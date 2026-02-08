class Solution:
    def nextPermutation(self, nums: list[int]) -> None:
        n = len(nums)

        k = n - 2
        while k >= 0 and nums[k] >= nums[k + 1]:
            k -= 1

        if k < 0:
            nums.reverse()
            return

        l = n - 1
        while nums[l] <= nums[k]:
            l -= 1

        nums[k], nums[l] = nums[l], nums[k]

        left = k + 1
        right = n - 1
        while left < right:
            nums[left], nums[right] = nums[right], nums[left]
            left += 1
            right -= 1