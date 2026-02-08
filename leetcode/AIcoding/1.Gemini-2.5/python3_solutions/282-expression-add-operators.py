class Solution:
    def addOperators(self, num: str, target: int) -> list[str]:
        results = []
        if not num:
            return results

        def dfs(index, current_expression_string, current_value, last_operand):
            if index == len(num):
                if current_value == target:
                    results.append(current_expression_string)
                return

            for i in range(index, len(num)):
                current_num_str = num[index : i + 1]

                if len(current_num_str) > 1 and current_num_str[0] == '0':
                    break

                current_num_val = int(current_num_str)

                if index == 0:
                    dfs(i + 1, current_num_str, current_num_val, current_num_val)
                else:
                    dfs(i + 1, current_expression_string + "+" + current_num_str, 
                        current_value + current_num_val, current_num_val)

                    dfs(i + 1, current_expression_string + "-" + current_num_str, 
                        current_value - current_num_val, -current_num_val)

                    dfs(i + 1, current_expression_string + "*" + current_num_str, 
                        current_value - last_operand + last_operand * current_num_val, 
                        last_operand * current_num_val)

        dfs(0, "", 0, 0)
        return results