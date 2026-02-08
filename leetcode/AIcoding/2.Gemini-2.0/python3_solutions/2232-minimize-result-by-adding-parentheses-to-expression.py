class Solution:
    def minimizeResult(self, expression: str) -> str:
        plus_index = expression.find('+')
        left = expression[:plus_index]
        right = expression[plus_index + 1:]

        min_val = float('inf')
        best_result = ""

        for i in range(len(left)):
            for j in range(len(right)):

                left_num = int(left[i:]) if i < len(left) else 1
                right_num = int(right[:j+1]) if j >= 0 else 1

                left_multiplier = int(left[:i]) if i > 0 else 1
                right_multiplier = int(right[j+1:]) if j+1 < len(right) else 1

                current_val = left_multiplier * (left_num + right_num) * right_multiplier

                if current_val < min_val:
                    min_val = current_val
                    best_result = left[:i] + "(" + left[i:] + "+" + right[:j+1] + ")" + right[j+1:]

        return best_result