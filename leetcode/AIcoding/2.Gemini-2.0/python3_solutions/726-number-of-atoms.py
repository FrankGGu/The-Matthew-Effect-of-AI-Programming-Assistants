class Solution:
    def countOfAtoms(self, formula: str) -> str:
        stack = [dict()]
        i = 0
        while i < len(formula):
            if formula[i].isupper():
                start = i
                i += 1
                while i < len(formula) and formula[i].islower():
                    i += 1
                atom = formula[start:i]
                count = 1
                if i < len(formula) and formula[i].isdigit():
                    start = i
                    i += 1
                    while i < len(formula) and formula[i].isdigit():
                        i += 1
                    count = int(formula[start:i])

                top = stack[-1]
                top[atom] = top.get(atom, 0) + count
            elif formula[i] == '(':
                stack.append(dict())
                i += 1
            elif formula[i] == ')':
                i += 1
                count = 1
                if i < len(formula) and formula[i].isdigit():
                    start = i
                    i += 1
                    while i < len(formula) and formula[i].isdigit():
                        i += 1
                    count = int(formula[start:i])

                top = stack.pop()
                for atom, c in top.items():
                    stack[-1][atom] = stack[-1].get(atom, 0) + c * count

        result = ""
        for atom in sorted(stack[-1].keys()):
            if stack[-1][atom] == 1:
                result += atom
            else:
                result += atom + str(stack[-1][atom])
        return result