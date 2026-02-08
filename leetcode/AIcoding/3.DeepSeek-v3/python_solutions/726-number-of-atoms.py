class Solution:
    def countOfAtoms(self, formula: str) -> str:
        stack = []
        i = 0
        n = len(formula)

        while i < n:
            if formula[i] == '(':
                stack.append('(')
                i += 1
            elif formula[i] == ')':
                i += 1
                num_str = ''
                while i < n and formula[i].isdigit():
                    num_str += formula[i]
                    i += 1
                num = int(num_str) if num_str else 1

                temp = []
                while stack and stack[-1] != '(':
                    elem, cnt = stack.pop()
                    temp.append((elem, cnt * num))
                stack.pop()  # Pop '('

                for elem, cnt in reversed(temp):
                    if stack and stack[-1] != '(' and stack[-1][0] == elem:
                        stack[-1] = (elem, stack[-1][1] + cnt)
                    else:
                        stack.append((elem, cnt))
            else:
                elem_start = i
                i += 1
                while i < n and formula[i].islower():
                    i += 1
                elem = formula[elem_start:i]

                num_str = ''
                while i < n and formula[i].isdigit():
                    num_str += formula[i]
                    i += 1
                num = int(num_str) if num_str else 1

                if stack and stack[-1] != '(' and stack[-1][0] == elem:
                    stack[-1] = (elem, stack[-1][1] + num)
                else:
                    stack.append((elem, num))

        stack.sort()
        res = []
        for elem, cnt in stack:
            res.append(elem)
            if cnt > 1:
                res.append(str(cnt))

        return ''.join(res)