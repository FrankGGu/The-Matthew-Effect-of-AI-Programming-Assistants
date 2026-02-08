class Solution:
    def isValid(self, code: str) -> bool:
        stack = []
        i = 0
        n = len(code)

        while i < n:
            if code[i] == '<':
                # Check if it's a closing tag
                if i + 1 < n and code[i + 1] == '/':
                    j = code.find('>', i)
                    if j == -1 or not stack:
                        return False
                    tag = code[i + 2:j]
                    if stack[-1] != tag:
                        return False
                    stack.pop()
                    i = j + 1
                else:
                    j = code.find('>', i)
                    if j == -1:
                        return False
                    tag = code[i + 1:j]
                    if not (1 <= len(tag) <= 9) or not tag.isalnum():
                        return False
                    stack.append(tag)
                    i = j + 1
            else:
                if not stack:
                    return False
                j = code.find('<', i)
                if j == -1:
                    return False
                i = j

        return not stack