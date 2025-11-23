class Solution:
    def tagValidator(self, code: str) -> bool:
        import re
        stack = []
        i = 0
        while i < len(code):
            if code[i] == '<':
                if i + 1 < len(code) and code[i + 1] == '/':
                    if not stack:
                        return False
                    j = i + 2
                    while j < len(code) and code[j] != '>':
                        j += 1
                    if j == len(code):
                        return False
                    tag = code[i + 2:j]
                    if not re.fullmatch(r'[A-Z]+', tag):
                        return False
                    if stack[-1] != tag:
                        return False
                    stack.pop()
                    i = j + 1
                else:
                    if i + 1 >= len(code) or code[i + 1] == '>':
                        return False
                    j = i + 1
                    while j < len(code) and code[j] != '>':
                        j += 1
                    if j == len(code):
                        return False
                    tag = code[i + 1:j]
                    if not re.fullmatch(r'[A-Z]+', tag):
                        return False
                    stack.append(tag)
                    i = j + 1
            else:
                i += 1
        return not stack