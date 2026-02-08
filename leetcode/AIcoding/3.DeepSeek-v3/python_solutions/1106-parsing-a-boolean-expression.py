class Solution:
    def parseBoolExpr(self, expression: str) -> bool:
        stack = []
        for c in expression:
            if c == ',':
                continue
            if c != ')':
                stack.append(c)
            else:
                trues = 0
                falses = 0
                while stack[-1] != '(':
                    val = stack.pop()
                    if val == 't':
                        trues += 1
                    else:
                        falses += 1
                stack.pop()  # pop '('
                op = stack.pop()
                if op == '&':
                    stack.append('t' if falses == 0 else 'f')
                elif op == '|':
                    stack.append('t' if trues > 0 else 'f')
                elif op == '!':
                    stack.append('t' if falses > 0 else 'f')
        return stack[-1] == 't'