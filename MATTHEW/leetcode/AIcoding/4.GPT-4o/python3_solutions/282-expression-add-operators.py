class Solution:
    def addOperators(self, num: str, target: int):
        res = []

        def backtrack(index, prev_operand, current_operand, value, expression):
            if index == len(num):
                if value == target and current_operand == 0:
                    res.append(expression)
                return

            current_num = num[index]
            current_index = index + 1

            backtrack(current_index, current_operand, current_operand * 10 + int(current_num), value, expression)

            if current_operand > 0:
                backtrack(current_index, current_operand, 0, value + current_operand, expression + '+' + current_num)
                backtrack(current_index, -current_operand, 0, value + current_operand, expression + '-' + current_num)
                backtrack(current_index, prev_operand * current_operand, 0, value - prev_operand + (prev_operand * current_operand), expression + '*' + current_num)

        backtrack(1, 0, int(num[0]), 0, num[0])
        return res