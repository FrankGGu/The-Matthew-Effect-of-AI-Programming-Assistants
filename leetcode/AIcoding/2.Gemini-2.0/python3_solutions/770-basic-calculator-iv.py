from collections import defaultdict

class Solution:
    def basicCalculatorIV(self, expression: str, evalvars: list[str], evalints: list[int]) -> list[str]:
        def evaluate(tokens, lookup):
            def multiply(poly1, poly2):
                result = defaultdict(int)
                for term1, coeff1 in poly1.items():
                    for term2, coeff2 in poly2.items():
                        new_term = tuple(sorted(term1 + term2))
                        result[new_term] += coeff1 * coeff2
                return result

            def add(poly1, poly2):
                result = defaultdict(int)
                for term, coeff in poly1.items():
                    result[term] += coeff
                for term, coeff in poly2.items():
                    result[term] += coeff
                return result

            def subtract(poly1, poly2):
                result = defaultdict(int)
                for term, coeff in poly1.items():
                    result[term] += coeff
                for term, coeff in poly2.items():
                    result[term] -= coeff
                return result

            def parse(tokens):
                result = defaultdict(int)
                if len(tokens) == 1:
                    token = tokens[0]
                    if token.isdigit() or (token[0] == '-' and token[1:].isdigit()):
                        result[()] = int(token)
                    else:
                        if token in lookup:
                            result[()] = lookup[token]
                        else:
                            result[(token,)] = 1
                else:
                    stack = []
                    ops = []
                    priority = {'+': 1, '-': 1, '*': 2}

                    def calculate(op):
                        poly2 = stack.pop()
                        poly1 = stack.pop()
                        if op == '+':
                            stack.append(add(poly1, poly2))
                        elif op == '-':
                            stack.append(subtract(poly1, poly2))
                        elif op == '*':
                            stack.append(multiply(poly1, poly2))

                    for token in tokens:
                        if token == '(':
                            ops.append(token)
                        elif token == ')':
                            while ops and ops[-1] != '(':
                                calculate(ops.pop())
                            ops.pop()
                        elif token in ['+', '-', '*']:
                            while ops and ops[-1] != '(' and priority[ops[-1]] >= priority[token]:
                                calculate(ops.pop())
                            ops.append(token)
                        else:
                            temp_tokens = [token]
                            stack.append(parse(temp_tokens))

                    while ops:
                        calculate(ops.pop())
                    result = stack[0]
                return result

            return parse(tokens)

        tokens = expression.replace('(', '( ').replace(')', ' )').split()
        tokens = [token for token in tokens if token != '']

        lookup = {}
        for var, val in zip(evalvars, evalints):
            lookup[var] = val

        poly = evaluate(tokens, lookup)
        result = []
        for term, coeff in poly.items():
            if coeff != 0:
                if term:
                    result.append("*".join([str(coeff)] + list(term)))
                else:
                    result.append(str(coeff))

        result.sort(key=lambda x: (x.count('*'),) + tuple(x.split('*')), reverse=True)
        return result