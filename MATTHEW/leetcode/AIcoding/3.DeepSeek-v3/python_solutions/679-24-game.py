import itertools

class Solution:
    def judgePoint24(self, nums: List[int]) -> bool:
        if len(nums) == 1:
            return abs(nums[0] - 24) < 1e-6

        for a, b, *rest in itertools.permutations(nums):
            for op in (lambda x, y: x + y, lambda x, y: x - y, lambda x, y: x * y, lambda x, y: x / y if y != 0 else float('inf')):
                next_nums = [op(a, b)] + rest
                if self.judgePoint24(next_nums):
                    return True
        return False