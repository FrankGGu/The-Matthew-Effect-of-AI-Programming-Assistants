class Solution:
    def minRemoveToMakeValid(self, s: str) -> str:
        stack = []
        remove = set()
        for i, char in enumerate(s):
            if char == '(':
                stack.append(i)
            elif char == ')':
                if stack:
                    stack.pop()
                else:
                    remove.add(i)
        remove = remove.union(set(stack))
        res = []
        for i, char in enumerate(s):
            if i not in remove:
                res.append(char)
        return "".join(res)