class NestedInteger:
    def __init__(self, value=None):
        self.value = value
        self.list = []

    def isInteger(self):
        return self.value is not None

    def getInteger(self):
        return self.value

    def setInteger(self, value):
        self.value = value

    def getList(self):
        return self.list

    def add(self, elem):
        self.list.append(elem)

class Solution:
    def deserialize(self, s: str) -> 'NestedInteger':
        if not s:
            return NestedInteger()
        if s[0] != '[':
            return NestedInteger(int(s))
        stack = []
        current = None
        i = 0
        while i < len(s):
            if s[i] == '[':
                stack.append(current)
                current = NestedInteger()
                i += 1
            elif s[i] == ']':
                if stack:
                    prev = stack.pop()
                    prev.add(current)
                    current = prev
                i += 1
            elif s[i] == ',':
                i += 1
            else:
                j = i
                while j < len(s) and s[j] not in ',]':
                    j += 1
                current.add(NestedInteger(int(s[i:j])))
                i = j
        return current