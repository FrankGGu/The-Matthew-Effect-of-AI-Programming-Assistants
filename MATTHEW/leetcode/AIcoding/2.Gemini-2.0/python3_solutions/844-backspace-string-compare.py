class Solution:
    def backspaceCompare(self, s: str, t: str) -> bool:
        def build_string(s):
            stack = []
            for char in s:
                if char == '#':
                    if stack:
                        stack.pop()
                else:
                    stack.append(char)
            return "".join(stack)

        return build_string(s) == build_string(t)