class Solution:
    def diffWaysToAddParentheses(self, expression: str) -> List[int]:
        if not expression:
            return []

        def helper(expr):
            if expr.isdigit():
                return [int(expr)]

            res = []
            for i in range(len(expr)):
                if expr[i] in '+-*':
                    left = helper(expr[:i])
                    right = helper(expr[i+1:])
                    for l in left:
                        for r in right:
                            if expr[i] == '+':
                                res.append(l + r)
                            elif expr[i] == '-':
                                res.append(l - r)
                            elif expr[i] == '*':
                                res.append(l * r)
            return res

        return helper(expression)