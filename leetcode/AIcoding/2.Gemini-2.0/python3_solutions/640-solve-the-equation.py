class Solution:
    def solveEquation(self, equation: str) -> str:
        left, right = equation.split('=')
        left_x, left_num = self.parse(left)
        right_x, right_num = self.parse(right)

        x_coeff = left_x - right_x
        num_coeff = right_num - left_num

        if x_coeff == 0:
            if num_coeff == 0:
                return "Infinite solutions"
            else:
                return "No solution"
        else:
            return "x=" + str(num_coeff // x_coeff)

    def parse(self, expr: str) -> tuple[int, int]:
        x_coeff = 0
        num_coeff = 0

        sign = 1
        num = 0
        i = 0
        while i < len(expr):
            if expr[i] == '+':
                num_coeff += sign * num
                num = 0
                sign = 1
                i += 1
            elif expr[i] == '-':
                num_coeff += sign * num
                num = 0
                sign = -1
                i += 1
            elif expr[i] == 'x':
                if num == 0:
                    if i > 0 and (expr[i-1] == '+' or expr[i-1] == '-'):
                        x_coeff += sign * 1
                    else:
                        x_coeff += sign * 1
                else:
                    x_coeff += sign * num
                num = 0
                i += 1
            else:
                j = i
                while j < len(expr) and expr[j].isdigit():
                    j += 1
                num = int(expr[i:j])
                i = j
        num_coeff += sign * num

        return x_coeff, num_coeff