class Solution:
    def basicCalculatorIV(self, expression: str, evalvars: List[str], evalints: List[int]) -> List[str]:
        from collections import defaultdict

        eval_map = {var: val for var, val in zip(evalvars, evalints)}
        stack = []
        postfix = []

        def precedence(op):
            if op in ('+', '-'):
                return 1
            if op in ('*', '/'):
                return 2
            return 0

        def apply_operator(operators, operands):
            right = operands.pop()
            left = operands.pop()
            op = operators.pop()
            if isinstance(left, str) and isinstance(right, str):
                return f"({left}{op}{right})"
            return f"({left}{op}{right})"

        def to_postfix(expression):
            operators = []
            for token in expression.split():
                if token.isalnum() or token.isidentifier():
                    postfix.append(token)
                elif token in {'+', '-', '*', '/'}:
                    while (operators and precedence(operators[-1]) >= precedence(token)):
                        postfix.append(apply_operator(operators, postfix))
                    operators.append(token)
            while operators:
                postfix.append(apply_operator(operators, postfix))

        to_postfix(expression)

        def evaluate(postfix):
            operands = []
            for token in postfix:
                if token.isalnum() or token.isidentifier():
                    if token in eval_map:
                        operands.append(eval_map[token])
                    else:
                        operands.append(token)
                else:
                    right = operands.pop()
                    left = operands.pop()
                    if isinstance(left, str) and isinstance(right, str):
                        operands.append(f"({left}{token}{right})")
                    else:
                        operands.append(f"({left}{token}{right})")
            return operands[0]

        final_expr = evaluate(postfix)

        from sympy import symbols, expand
        from collections import Counter

        x = symbols('x')
        expanded = expand(final_expr)

        counter = Counter(expanded.as_ordered_terms())
        result = []

        for term, coeff in counter.items():
            if coeff == 1:
                result.append(str(term))
            elif coeff == -1:
                result.append(f"-{term}")
            else:
                result.append(f"{coeff}{term}")

        return sorted(result)