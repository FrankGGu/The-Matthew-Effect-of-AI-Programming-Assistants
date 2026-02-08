from collections import defaultdict

class Solution:
    def basicCalculatorIV(self, expression: str, evalvars: List[str], evalints: List[int]) -> List[str]:
        def parse():
            nonlocal i
            res = defaultdict(int)
            while i < len(expression):
                if expression[i] == ' ':
                    i += 1
                    continue
                if expression[i] == '(':
                    i += 1
                    term = parse()
                    i += 1
                else:
                    term = get_term()
                if i < len(expression) and expression[i] == '*':
                    i += 1
                    if expression[i] == ' ':
                        i += 1
                    if expression[i] == '(':
                        i += 1
                        term2 = parse()
                        i += 1
                    else:
                        term2 = get_term()
                    term = multiply(term, term2)
                if i >= len(expression) or expression[i] != '+':
                    add(res, term)
                    return res
                add(res, term)
                i += 1
            return res

        def get_term():
            nonlocal i
            if expression[i] == '-':
                sign = -1
                i += 1
                if expression[i] == ' ':
                    i += 1
            else:
                sign = 1
            if expression[i].isdigit():
                num = 0
                while i < len(expression) and expression[i].isdigit():
                    num = num * 10 + int(expression[i])
                    i += 1
                term = defaultdict(int)
                term[()] = num * sign
            else:
                var = []
                while i < len(expression) and expression[i] not in ' )*+':
                    if expression[i] == ' ':
                        i += 1
                        continue
                    var.append(expression[i])
                    i += 1
                var_str = ''.join(var)
                if var_str in var_map:
                    term = defaultdict(int)
                    term[()] = var_map[var_str] * sign
                else:
                    term = defaultdict(int)
                    term[(var_str,)] = sign
            return term

        def multiply(t1, t2):
            res = defaultdict(int)
            for k1 in t1:
                for k2 in t2:
                    new_key = tuple(sorted(k1 + k2))
                    res[new_key] += t1[k1] * t2[k2]
            return res

        def add(t1, t2):
            for k in t2:
                t1[k] += t2[k]

        var_map = {}
        for var, val in zip(evalvars, evalints):
            var_map[var] = val

        i = 0
        poly = parse()
        sorted_terms = sorted(poly.keys(), key=lambda x: (-len(x), x))
        res = []
        for term in sorted_terms:
            coeff = poly[term]
            if coeff == 0:
                continue
            if not term:
                res.append(str(coeff))
            else:
                res.append(f"{coeff}*{'*'.join(term)}")
        return res