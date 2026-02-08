class Solution:
    def solveEquation(self, equation: str) -> str:
        left, right = equation.split('=')

        def parse_side(side):
            coef, constant = 0, 0
            num = ''
            sign = 1
            for i in range(len(side)):
                if side[i] in '+-':
                    if num:
                        if 'x' in num:
                            coef += sign * (int(num[:-1]) if num[:-1] else 1)
                        else:
                            constant += sign * int(num)
                        num = ''
                    sign = 1 if side[i] == '+' else -1
                elif side[i].isdigit() or side[i] == 'x':
                    num += side[i]
                if i == len(side) - 1:
                    if num:
                        if 'x' in num:
                            coef += sign * (int(num[:-1]) if num[:-1] else 1)
                        else:
                            constant += sign * int(num)
            return coef, constant

        left_coef, left_const = parse_side(left)
        right_coef, right_const = parse_side(right)

        total_coef = left_coef - right_coef
        total_const = right_const - left_const

        if total_coef == 0:
            return "Infinite solutions" if total_const == 0 else "No solution"

        x_value = total_const // total_coef
        return f"x={x_value}"