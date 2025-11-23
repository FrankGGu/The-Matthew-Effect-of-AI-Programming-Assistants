class Solution:
    def maximizeGreatness(self, nums: List[int]) -> int:
        nums.sort()
        greatness = 0
        for num in nums:
            if greatness < num:
                greatness += 1
        return greatness