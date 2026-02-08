class Solution:
    def makeStringEmpty(self, s: str) -> str:
        stack = []
        operations = []
        n = len(s)
        i = 0
        while i < n:
            stack.append(s[i])
            i += 1
            while i < n and stack and s[i] == stack[-1]:
                stack.append(s[i])
                i += 1
            if len(stack) >= 2 and stack[-1] == stack[-2]:
                operations.append(f"Push {stack[-1]}")
                operations.append("Pop")
                stack.pop()
                stack.pop()
        while stack:
            operations.append(f"Push {stack[-1]}")
            operations.append("Pop")
            stack.pop()
        return operations