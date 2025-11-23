class Solution:
    def findTheArrayConcatenationValue(self, nums: list[int]) -> int:
        concatenation_value = 0
        left = 0
        right = len(nums) - 1

        while left <= right:
            if left == right:
                concatenation_value += nums[left]
            else:
                s1 = str(nums[left])
                s2 = str(nums[right])
                concatenation_value += int(s1 + s2)

            left += 1
            right -= 1

        return concatenation_value