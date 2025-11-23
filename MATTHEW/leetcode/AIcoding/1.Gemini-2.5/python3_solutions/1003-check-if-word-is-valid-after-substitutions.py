class Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        for char in s:
            if char == 'c':
                # To form 'abc', the stack must contain 'a' then 'b' immediately before 'c'.
                if len(stack) < 2 or stack[-1] != 'b' or stack[-2] != 'a':
                    return False
                # If 'abc' sequence is found, pop 'b' and 'a' from the stack.
                stack.pop() # Remove 'b'
                stack.pop() # Remove 'a'
            else:
                # For 'a' or 'b', simply push onto the stack.
                stack.append(char)

        # A string is valid if and only if the stack is empty at the end.
        return not stack