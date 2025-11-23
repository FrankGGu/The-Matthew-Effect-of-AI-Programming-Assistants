from math import comb

class Solution:
    def numOfWays(self, nums: List[int]) -> int:
        def count_ways(subtree):
            if len(subtree) <= 2:
                return 1
            left = [x for x in subtree if x < subtree[0]]
            right = [x for x in subtree if x > subtree[0]]
            left_ways = count_ways(left)
            right_ways = count_ways(right)
            total_ways = comb(len(left) + len(right), len(left))
            return total_ways * left_ways * right_ways

        return (count_ways(nums) - 1) % (10**9 + 7)