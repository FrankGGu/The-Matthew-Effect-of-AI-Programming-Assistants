class Solution:
    def minimumValue(self, s: str) -> int:
        stack = []
        for c in s:
            if stack and ord(c) - ord(stack[-1]) == 1:
                stack.pop()
            else:
                stack.append(c)
        return len(stack)