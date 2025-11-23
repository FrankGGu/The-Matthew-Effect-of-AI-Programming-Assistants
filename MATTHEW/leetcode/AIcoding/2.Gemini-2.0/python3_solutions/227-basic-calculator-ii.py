class Solution:
    def calculate(self, s: str) -> int:
        stack = []
        num = 0
        op = '+'
        s += '+' 

        for i in range(len(s)):
            if s[i].isdigit():
                num = num * 10 + int(s[i])
            elif s[i] in '+-*/':
                if op == '+':
                    stack.append(num)
                elif op == '-':
                    stack.append(-num)
                elif op == '*':
                    stack.append(stack.pop() * num)
                elif op == '/':
                    stack.append(int(stack.pop() / num))

                op = s[i]
                num = 0

        return sum(stack)