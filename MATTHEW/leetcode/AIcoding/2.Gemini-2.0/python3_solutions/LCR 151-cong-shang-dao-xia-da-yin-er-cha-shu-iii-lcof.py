class Solution:
    def decorateRecord(self, record: str) -> int:
        stack = []
        count = 0
        for char in record:
            if char == '(':
                stack.append('(')
            elif char == ')':
                if stack and stack[-1] == '(':
                    stack.pop()
                    count += 2
                else:
                    return -1
            else:
                return -1
        if stack:
            return -1
        return count