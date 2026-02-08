class Solution:
    def judgePoint24(self, nums: list[int]) -> bool:
        if not nums:
            return False
        if len(nums) == 1:
            return abs(nums[0] - 24) < 1e-6

        for i in range(len(nums)):
            for j in range(i + 1, len(nums)):
                next_nums = []
                for k in range(len(nums)):
                    if k != i and k != j:
                        next_nums.append(nums[k])

                a, b = nums[i], nums[j]
                if self.judgePoint24(next_nums + [a + b]):
                    return True
                if self.judgePoint24(next_nums + [a - b]):
                    return True
                if self.judgePoint24(next_nums + [a * b]):
                    return True
                if b != 0 and self.judgePoint24(next_nums + [a / b]):
                    return True
                if self.judgePoint24(next_nums + [b - a]):
                    return True
                if a != 0 and self.judgePoint24(next_nums + [b / a]):
                    return True

        return False