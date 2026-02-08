class Solution:
    def calculateScore(self, nums: List[int], instructions: List[List[int]]) -> List[int]:
        n = len(nums)
        res = []
        for op in instructions:
            if op[0] == 0:
                nums.insert(op[1], op[2])
            elif op[0] == 1:
                nums.pop(op[1])
            elif op[0] == 2:
                nums[op[1]] += op[2]
            score = 0
            for i in range(len(nums) - 1):
                score += abs(nums[i] - nums[i + 1])
            res.append(score)
        return res