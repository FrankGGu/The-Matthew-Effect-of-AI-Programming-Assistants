class Solution:
    def solveEquation(self, equation: str) -> str:

        def parse(expression: str) -> tuple[int, int]:
            coeff_x = 0
            const_val = 0
            current_sign = 1 # 1 for '+', -1 for '-'
            i = 0
            n = len(expression)

            while i < n:
                if expression[i] == '+':
                    current_sign = 1
                    i += 1
                elif expression[i] == '-':
                    current_sign = -1
                    i += 1
                else:
                    # It's either a number or 'x'
                    num_start = i
                    while i < n and expression[i].isdigit():
                        i += 1

                    if i == num_start: # Current char is 'x'
                        coeff_x += current_sign
                        i += 1 # Move past 'x'
                    else: # We found a number
                        num = int(expression[num_start:i])
                        if i < n and expression[i] == 'x': # It's a coefficient for 'x'
                            coeff_x += current_sign * num
                            i += 1 # Move past 'x'
                        else: # It's a constant
                            const_val += current_sign * num

            return coeff_x, const_val

        left_expr, right_expr = equation.split('=')

        left_coeff_x, left_const_val = parse(left_expr)
        right_coeff_x, right_const_val = parse(right_expr)

        # Rearrange to: (left_coeff_x - right_coeff_x) * x = right_const_val - left_const_val

        total_coeff_x = left_coeff_x - right_coeff_x
        total_const_val = right_const_val - left_const_val

        if total_coeff_x == 0:
            if total_const_val == 0:
                return "Infinite solutions"
            else:
                return "No solution"
        else:
            # total_coeff_x * x = total_const_val
            # x = total_const_val / total_coeff_x
            return "x=" + str(total_const_val // total_coeff_x)