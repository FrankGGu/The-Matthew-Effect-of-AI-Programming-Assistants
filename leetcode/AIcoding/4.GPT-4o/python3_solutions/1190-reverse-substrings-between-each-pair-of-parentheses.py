class Solution:
    def reverseParentheses(self, s: str) -> str:
        stack = []
        curr = []

        for char in s:
            if char == '(':
                stack.append(curr)
                curr = []
            elif char == ')':
                curr.reverse()
                curr = stack.pop() + curr
            else:
                curr.append(char)

        return ''.join(curr)