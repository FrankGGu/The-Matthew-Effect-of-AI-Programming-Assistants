class Solution:
    def backspaceCompare(self, s: str, t: str) -> bool:
        def process_string(string: str) -> str:
            stack = []
            for char in string:
                if char == '#':
                    if stack:
                        stack.pop()
                else:
                    stack.append(char)
            return "".join(stack)

        return process_string(s) == process_string(t)