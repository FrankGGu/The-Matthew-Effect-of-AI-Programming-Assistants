class Solution:
    def singleNumber(self, nums: List[int]) to int:
        seen_once = seen_twice = 0
        for num in nums:
            seen_once = (seen_once ^ num) & ~seen_twice
            seen_twice = (seen_twice ^ num) & ~seen_once
        return seen_once