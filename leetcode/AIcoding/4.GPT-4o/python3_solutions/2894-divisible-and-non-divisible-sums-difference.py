class Solution:
    def differenceOfSum(self, nums: List[int]) -> int:
        divisible_sum = sum(x for x in nums if x % 3 == 0)
        non_divisible_sum = sum(x for x in nums if x % 3 != 0)
        return divisible_sum - non_divisible_sum