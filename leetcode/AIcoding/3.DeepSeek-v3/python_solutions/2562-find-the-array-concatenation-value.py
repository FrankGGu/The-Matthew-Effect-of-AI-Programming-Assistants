class Solution:
    def findTheArrayConcVal(self, nums: List[int]) -> int:
        left, right = 0, len(nums) - 1
        total = 0
        while left <= right:
            if left == right:
                total += nums[left]
            else:
                concat = int(str(nums[left]) + str(nums[right]))
                total += concat
            left += 1
            right -= 1
        return total