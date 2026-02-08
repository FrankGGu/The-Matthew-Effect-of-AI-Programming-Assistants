class Solution:
    def rearrangeArray(self, nums: List[int]) -> List[int]:
        nums.sort()
        n = len(nums)
        result = [0] * n
        left, right = 0, n - 1
        for i in range(n):
            if i % 2 == 0:
                result[i] = nums[left]
                left += 1
            else:
                result[i] = nums[right]
                right -= 1
        return result