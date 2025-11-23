class Solution:
    def record_decoration(self, record: str) -> str:
        stack = []
        for char in record:
            if stack and stack[-1] == char:
                stack.pop()
            else:
                stack.append(char)
        return "".join(stack)