class Solution:
    def prevPerms(self, nums: List[int]) -> List[int]:
        n = len(nums)
        if n <= 1:
            return nums

        for i in range(n - 2, -1, -1):
            if nums[i] > nums[i + 1]:
                break
        else:
            return sorted(nums)

        for j in range(n - 1, i, -1):
            if nums[j] < nums[i]:
                nums[i], nums[j] = nums[j], nums[i]
                break

        nums[i + 1:] = reversed(nums[i + 1:])
        return nums