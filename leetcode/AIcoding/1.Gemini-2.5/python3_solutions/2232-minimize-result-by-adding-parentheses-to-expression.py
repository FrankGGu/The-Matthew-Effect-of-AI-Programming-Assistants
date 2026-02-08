class Solution:
    def minimizeResult(self, expression: str) -> str:
        plus_idx = expression.find('+')
        n = len(expression)

        min_res = float('inf')
        best_expr = ""

        for i in range(plus_idx):
            for j in range(plus_idx + 1, n):
                num1_inner = int(expression[i:plus_idx])
                num2_inner = int(expression[plus_idx+1:j+1])
                val_inner = num1_inner + num2_inner

                prefix_val = 1
                if i > 0:
                    prefix_val = int(expression[0:i])

                suffix_val = 1
                if j < n - 1:
                    suffix_val = int(expression[j+1:n])

                current_res = prefix_val * val_inner * suffix_val

                if current_res < min_res:
                    min_res = current_res
                    best_expr = expression[0:i] + '(' + expression[i:j+1] + ')' + expression[j+1:n]

        return best_expr