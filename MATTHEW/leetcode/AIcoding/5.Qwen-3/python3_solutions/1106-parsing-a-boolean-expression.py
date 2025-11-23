class Solution:
    def parseBoolExpr(self, expression: str) -> bool:
        def evaluate(expr, i):
            if expr[i[0]] == 't':
                i[0] += 1
                return True
            if expr[i[0]] == 'f':
                i[0] += 1
                return False
            if expr[i[0]] == '!':
                i[0] += 2
                res = evaluate(expr, i)
                i[0] += 1
                return not res
            if expr[i[0]] == '&':
                i[0] += 2
                res = True
                while expr[i[0]] != ')':
                    res &= evaluate(expr, i)
                i[0] += 1
                return res
            if expr[i[0]] == '|':
                i[0] += 2
                res = False
                while expr[i[0]] != ')':
                    res |= evaluate(expr, i)
                i[0] += 1
                return res
        i = [0]
        return evaluate(expression, i)