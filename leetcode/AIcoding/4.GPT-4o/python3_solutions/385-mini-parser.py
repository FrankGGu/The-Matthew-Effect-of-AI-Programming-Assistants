class NestedInteger:
    def __init__(self, value=None):
        if value is not None:
            self.value = value
            self.is_integer = True
        else:
            self.value = []
            self.is_integer = False

    def isInteger(self):
        return self.is_integer

    def add(self, ni):
        self.value.append(ni)

    def setInteger(self, value):
        self.value = value
        self.is_integer = True

    def getInteger(self):
        return self.value if self.is_integer else None

    def getList(self):
        return self.value if not self.is_integer else None

class Solution:
    def deserialize(self, s: str) -> NestedInteger:
        if s[0] != '[':
            return NestedInteger(int(s))

        stack = []
        current = NestedInteger()
        num = ''

        for char in s:
            if char == '[':
                stack.append(current)
                current = NestedInteger()
            elif char == ']':
                if num:
                    current.add(NestedInteger(int(num)))
                    num = ''
                if stack:
                    top = stack.pop()
                    top.add(current)
                    current = top
            elif char == ',':
                if num:
                    current.add(NestedInteger(int(num)))
                    num = ''
            else:
                num += char

        return current