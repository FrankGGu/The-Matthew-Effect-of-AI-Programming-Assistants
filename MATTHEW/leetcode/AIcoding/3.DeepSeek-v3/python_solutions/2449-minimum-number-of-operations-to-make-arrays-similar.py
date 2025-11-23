class Solution:
    def makeSimilar(self, nums: List[int], target: List[int]) -> int:
        nums_odd = sorted([x for x in nums if x % 2 == 1])
        nums_even = sorted([x for x in nums if x % 2 == 0])
        target_odd = sorted([x for x in target if x % 2 == 1])
        target_even = sorted([x for x in target if x % 2 == 0])

        res = 0
        for a, b in zip(nums_odd, target_odd):
            res += abs(a - b) // 2
        for a, b in zip(nums_even, target_even):
            res += abs(a - b) // 2

        return res // 2