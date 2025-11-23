import re

class Solution:
    def isValid(self, code: str) -> bool:
        stack = []
        i = 0
        n = len(code)

        while i < n:
            if i > 0 and not stack:
                return False

            if code.startswith('<![CDATA[', i):
                j = i + 9
                i = code.find(']]>', j)
                if i == -1:
                    return False
                i += 3
            elif code.startswith('</', i):
                j = i + 2
                i = code.find('>', j)
                if i == -1:
                    return False
                tag = code[j:i]
                if not stack or stack.pop() != tag:
                    return False
                i += 1
            elif code.startswith('<', i):
                j = i + 1
                i = code.find('>', j)
                if i == -1:
                    return False
                tag = code[j:i]
                if not re.fullmatch('[A-Z]{1,9}', tag):
                    return False
                stack.append(tag)
                i += 1
            else:
                i += 1

        return not stack