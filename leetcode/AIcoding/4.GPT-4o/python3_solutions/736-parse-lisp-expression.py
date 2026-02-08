class Solution:
    def evaluate(self, expression: str) -> int:
        def eval_expr(expr):
            if expr[0] != '(':
                return int(expr) if expr.isdigit() or (expr[0] == '-' and expr[1:].isdigit()) else variables[expr]
            stack = []
            i = 1
            while i < len(expr) - 1:
                if expr[i] == '(':
                    j = i
                    while j < len(expr):
                        if expr[j] == '(':
                            count += 1
                        elif expr[j] == ')':
                            count -= 1
                        if count == 0:
                            break
                        j += 1
                    stack.append(eval_expr(expr[i:j + 1]))
                    i = j + 1
                    continue
                if expr[i] in operations:
                    op = expr[i]
                    i += 1
                elif expr[i].isdigit() or (expr[i] == '-' and expr[i + 1].isdigit()):
                    num = ''
                    while i < len(expr) and (expr[i].isdigit() or expr[i] in '-'):
                        num += expr[i]
                        i += 1
                    stack.append(int(num))
                    continue
                else:
                    var = ''
                    while i < len(expr) and expr[i] not in '()':
                        var += expr[i]
                        i += 1
                    stack.append(variables[var])
                    continue
                i += 1

            result = stack[0]
            for i in range(1, len(stack)):
                if op == 'add':
                    result += stack[i]
                elif op == 'mult':
                    result *= stack[i]
            return result

        variables = {}
        operations = {'add', 'mult'}
        return eval_expr(expression)