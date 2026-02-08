class Solution:
    def minimizeResult(self, expression: str) -> str:
        plus_pos = expression.find('+')
        left = expression[:plus_pos]
        right = expression[plus_pos + 1:]
        min_val = float('inf')
        res = ""

        for i in range(len(left)):
            for j in range(1, len(right) + 1):
                a = left[:i] if i > 0 else ""
                b = left[i:]
                c = right[:j]
                d = right[j:] if j < len(right) else ""

                a_val = int(a) if a else 1
                b_val = int(b)
                c_val = int(c)
                d_val = int(d) if d else 1

                current = a_val * (b_val + c_val) * d_val

                if current < min_val:
                    min_val = current
                    res = f"{a}({b}+{c}){d}"

        return res