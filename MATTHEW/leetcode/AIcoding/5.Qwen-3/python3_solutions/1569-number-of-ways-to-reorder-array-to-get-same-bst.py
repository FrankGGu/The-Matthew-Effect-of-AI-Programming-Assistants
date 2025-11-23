class Solution:
    def numOfWays(self, nums: List[int]) -> int:
        from math import comb

        def count_ways(sub_nums):
            if len(sub_nums) <= 1:
                return 1
            root = sub_nums[0]
            left = [x for x in sub_nums[1:] if x < root]
            right = [x for x in sub_nums[1:] if x > root]
            left_ways = count_ways(left)
            right_ways = count_ways(right)
            return comb(len(left) + len(right), len(left)) * left_ways * right_ways

        total = count_ways(nums)
        return total - 1