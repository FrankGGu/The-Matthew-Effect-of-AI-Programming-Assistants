class Solution:
    def addOperators(self, num: str, target: int) -> List[str]:
        def backtrack(index, path, value, prev_operand):
            if index == len(num):
                if value == target:
                    res.append(path)
                return

            for i in range(index, len(num)):
                if i != index and num[index] == '0':
                    break
                current_str = num[index:i+1]
                current_num = int(current_str)
                if index == 0:
                    backtrack(i+1, current_str, current_num, current_num)
                else:
                    backtrack(i+1, path + '+' + current_str, value + current_num, current_num)
                    backtrack(i+1, path + '-' + current_str, value - current_num, -current_num)
                    backtrack(i+1, path + '*' + current_str, value - prev_operand + prev_operand * current_num, prev_operand * current_num)

        res = []
        backtrack(0, "", 0, 0)
        return res