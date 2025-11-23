class Solution:
    def solveEquation(self, equation: str) -> str:
        def parse(expr):
            x_coeff = 0
            const = 0
            i = 0
            n = len(expr)
            sign = 1
            while i < n:
                if expr[i] == '+':
                    sign = 1
                    i += 1
                elif expr[i] == '-':
                    sign = -1
                    i += 1
                else:
                    num_str = ''
                    while i < n and expr[i].isdigit():
                        num_str += expr[i]
                        i += 1
                    if i < n and expr[i] == 'x':
                        if num_str:
                            x_coeff += sign * int(num_str)
                        else:
                            x_coeff += sign * 1
                        i += 1
                    else:
                        if num_str:
                            const += sign * int(num_str)
            return x_coeff, const

        left, right = equation.split('=')
        left_x, left_const = parse(left)
        right_x, right_const = parse(right)

        total_x = left_x - right_x
        total_const = right_const - left_const

        if total_x == 0 and total_const == 0:
            return "Infinite solutions"
        elif total_x == 0:
            return "No solution"
        else:
            return f"x={total_const // total_x}"