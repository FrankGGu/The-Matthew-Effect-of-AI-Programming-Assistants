class Solution:
    def minimizeResult(self, expression: str) -> str:
        parts = expression.split('+')
        a, b = parts[0], parts[1].split(' ')
        left, right = a[:-1], a[-1]
        right = b[0]
        b = b[1]

        min_value = float('inf')
        result = ''

        for i in range(len(a)):
            for j in range(i + 1, len(a) + 1):
                for k in range(len(b)):
                    for l in range(k + 1, len(b) + 1):
                        left_expr = a[:i] + '(' + a[i:j] + '+' + b[:k] + ')'
                        right_expr = b[k:l] + b[l:]
                        if right_expr:
                            value = eval(left_expr + right_expr)
                        else:
                            value = eval(left_expr)
                        if value < min_value:
                            min_value = value
                            result = left_expr + right_expr

        return result