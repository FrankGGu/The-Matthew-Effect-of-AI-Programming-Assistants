class Solution:
    def rearrangeArray(self, nums: List[int]) -> List[int]:
        nums.sort()
        n = len(nums)
        res = []
        left, right = 0, n - 1
        while left <= right:
            if left == right:
                res.append(nums[left])
            else:
                res.append(nums[left])
                res.append(nums[right])
            left += 1
            right -= 1
        return res