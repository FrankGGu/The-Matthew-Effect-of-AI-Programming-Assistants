class Solution:
    def parseBoolExpr(self, expression: str) -> bool:
        def evaluate(exp):
            if exp == 't':
                return True
            elif exp == 'f':
                return False
            elif exp[0] == '!':
                return not evaluate(exp[2:-1])
            elif exp[0] == '&':
                return all(evaluate(e.strip()) for e in self.split(exp[2:-1]))
            elif exp[0] == '|':
                return any(evaluate(e.strip()) for e in self.split(exp[2:-1]))

        return evaluate(expression)

    def split(self, exp):
        level = 0
        start = 0
        result = []
        for i, c in enumerate(exp):
            if c == ',' and level == 0:
                result.append(exp[start:i])
                start = i + 1
            elif c == '(':
                level += 1
            elif c == ')':
                level -= 1
        result.append(exp[start:])
        return result