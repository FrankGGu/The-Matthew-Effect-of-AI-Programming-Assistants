class Solution:
    def findClosestNumber(self, nums: list[int]) -> int:
        closest_num = nums[0]

        for i in range(1, len(nums)):
            num = nums[i]
            abs_num = abs(num)
            abs_closest = abs(closest_num)

            if abs_num < abs_closest:
                closest_num = num
            elif abs_num == abs_closest:
                if num > closest_num:
                    closest_num = num

        return closest_num