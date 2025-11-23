class Solution:
    def solveEquation(self, equation: str) -> str:
        def parse(expr):
            x_coeff = 0
            const = 0
            i = 0
            n = len(expr)
            while i < n:
                if expr[i] == '+':
                    sign = 1
                    i += 1
                elif expr[i] == '-':
                    sign = -1
                    i += 1
                else:
                    sign = 1
                if i < n and expr[i] == 'x':
                    x_coeff += sign
                    i += 1
                else:
                    num = 0
                    while i < n and expr[i].isdigit():
                        num = num * 10 + int(expr[i])
                        i += 1
                    if i < n and expr[i] == 'x':
                        x_coeff += sign * num
                        i += 1
                    else:
                        const += sign * num
            return x_coeff, const

        left, right = equation.split('=')
        left_x, left_const = parse(left)
        right_x, right_const = parse(right)
        x = left_x - right_x
        constant = right_const - left_const
        if x == 0:
            if constant == 0:
                return "Infinite solutions"
            else:
                return "No solution"
        else:
            return f"x={constant // x}"