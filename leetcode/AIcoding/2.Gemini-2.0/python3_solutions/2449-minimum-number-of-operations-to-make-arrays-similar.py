class Solution:
    def makeSimilar(self, nums: List[int], target: List[int]) -> int:
        odd_nums = sorted([x for x in nums if x % 2 != 0])
        even_nums = sorted([x for x in nums if x % 2 == 0])
        odd_target = sorted([x for x in target if x % 2 != 0])
        even_target = sorted([x for x in target if x % 2 == 0])

        ops = 0

        i = 0
        j = 0
        while i < len(odd_nums):
            diff = odd_target[i] - odd_nums[i]
            if diff > 0:
                ops += diff // 2
            i += 1

        i = 0
        j = 0
        while i < len(even_nums):
            diff = even_target[i] - even_nums[i]
            if diff > 0:
                ops += diff // 2
            i += 1

        return ops