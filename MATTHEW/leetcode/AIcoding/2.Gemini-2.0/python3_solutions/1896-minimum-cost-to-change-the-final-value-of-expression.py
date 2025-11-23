class Solution:
    def minOperationsToFlip(self, expression: str) -> int:
        def calculate(s):
            vals = []
            ops = []

            def eval_top():
                op = ops.pop()
                v2 = vals.pop()
                v1 = vals.pop()
                if op == '&':
                    vals.append((min(v1[0], v2[0] + v1[1], v1[0] + v2[1]), min(v1[1], v2[1] + v1[0], v1[1] + v2[0])))
                else:
                    vals.append((min(v1[0] + v2[0], v1[1], v2[1]), min(v1[1] + v2[1], v1[0], v2[0])))

            i = 0
            while i < len(s):
                if s[i].isdigit():
                    vals.append((int(s[i]) ^ 1, int(s[i])))
                elif s[i] == '(':
                    ops.append(s[i])
                elif s[i] == ')':
                    while ops[-1] != '(':
                        eval_top()
                    ops.pop()
                elif s[i] in ['&', '|']:
                    while ops and ops[-1] in ['&', '|']:
                        eval_top()
                    ops.append(s[i])
                i += 1

            while ops:
                eval_top()

            return vals[0]

        return min(calculate(expression))