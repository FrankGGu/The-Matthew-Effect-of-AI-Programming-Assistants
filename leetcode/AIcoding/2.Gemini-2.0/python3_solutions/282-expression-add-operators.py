class Solution:
    def addOperators(self, num: str, target: int) -> list[str]:
        res = []

        def backtrack(index, current_expression, current_value, previous_operand):
            if index == len(num):
                if current_value == target:
                    res.append(current_expression)
                return

            for j in range(index, len(num)):
                if j > index and num[index] == '0':
                    break
                current_num = int(num[index:j + 1])

                if index == 0:
                    backtrack(j + 1, str(current_num), current_num, current_num)
                else:
                    backtrack(j + 1, current_expression + "+" + str(current_num), current_value + current_num, current_num)
                    backtrack(j + 1, current_expression + "-" + str(current_num), current_value - current_num, -current_num)
                    backtrack(j + 1, current_expression + "*" + str(current_num), current_value - previous_operand + previous_operand * current_num, previous_operand * current_num)

        backtrack(0, "", 0, 0)
        return res