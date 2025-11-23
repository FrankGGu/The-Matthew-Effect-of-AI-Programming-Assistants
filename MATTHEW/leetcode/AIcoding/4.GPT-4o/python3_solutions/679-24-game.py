class Solution:
    def judgePoint24(self, cards: List[int]) -> bool:
        from itertools import permutations

        def evaluate(a, b, op):
            if op == '+':
                return a + b
            elif op == '-':
                return a - b
            elif op == '*':
                return a * b
            elif op == '/':
                return a / b if b != 0 else float('inf')

        def can_make_24(nums):
            if len(nums) == 1:
                return abs(nums[0] - 24) < 1e-6

            for i in range(len(nums)):
                for j in range(len(nums)):
                    if i != j:
                        next_nums = [nums[k] for k in range(len(nums)) if k != i and k != j]
                        for op in ['+', '-', '*', '/']:
                            if (op == '/' and nums[j] == 0) or (op in ['-', '/'] and i > j):
                                continue
                            next_num = evaluate(nums[i], nums[j], op)
                            if can_make_24(next_nums + [next_num]):
                                return True
            return False

        return can_make_24(cards)