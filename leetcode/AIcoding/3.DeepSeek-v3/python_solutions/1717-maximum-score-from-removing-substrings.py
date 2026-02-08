class Solution:
    def maximumGain(self, s: str, x: int, y: int) -> int:
        a = 'a'
        b = 'b'
        if x < y:
            x, y = y, x
            a, b = b, a
        res = 0
        stack = []
        for c in s:
            if stack and stack[-1] == a and c == b:
                stack.pop()
                res += x
            else:
                stack.append(c)
        s = ''.join(stack)
        stack = []
        for c in s:
            if stack and stack[-1] == b and c == a:
                stack.pop()
                res += y
            else:
                stack.append(c)
        return res