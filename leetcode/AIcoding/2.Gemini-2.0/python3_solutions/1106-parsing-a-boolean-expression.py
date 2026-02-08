class Solution:
    def parseBoolExpr(self, expression: str) -> bool:
        def evaluate(expr):
            if expr == 't':
                return True
            if expr == 'f':
                return False

            op = expr[0]
            values = []
            i = 2
            start = 2
            count = 0
            while i < len(expr) - 1:
                if expr[i] == '(':
                    count += 1
                elif expr[i] == ')':
                    count -= 1
                elif expr[i] == ',' and count == 0:
                    values.append(evaluate(expr[start:i]))
                    start = i + 1
                i += 1
            values.append(evaluate(expr[start:i]))

            if op == '&':
                return all(values)
            elif op == '|':
                return any(values)
            else:
                return not values[0]

        return evaluate(expression)