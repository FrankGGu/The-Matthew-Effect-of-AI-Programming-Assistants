class NestedInteger:
    def __init__(self, value=None):
        """
        If value is not specified, initializes an empty list.
        Otherwise initializes a single integer equal to value.
        """
        if value is None:
            self._integer = None
            self._list = []
        else:
            self._integer = value
            self._list = None

    def isInteger(self):
        """
        @return True if this NestedInteger holds a single integer, rather than a nested list.
        :rtype bool
        """
        return self._integer is not None

    def getInteger(self):
        """
        @return the single integer that this NestedInteger holds, if it holds a single integer
        Return None if this NestedInteger holds a nested list
        :rtype int
        """
        return self._integer

    def setInteger(self, value):
        """
        Set this NestedInteger to hold a single integer equal to value.
        :rtype void
        """
        self._integer = value
        self._list = None

    def add(self, elem):
        """
        Set this NestedInteger to hold a nested list and adds a nested integer elem to it.
        :rtype void
        """
        if self._integer is not None:
            self._list = [NestedInteger(self._integer)]
            self._integer = None
        self._list.append(elem)

    def getList(self):
        """
        @return the nested list that this NestedInteger holds, if it holds a nested list
        Return None if this NestedInteger holds a single integer
        :rtype List[NestedInteger]
        """
        return self._list

class Solution:
    def deserialize(self, s: str) -> NestedInteger:
        if not s:
            return NestedInteger()

        if s[0] != '[':
            return NestedInteger(int(s))

        stack = []
        num = 0
        sign = 1

        for i, c in enumerate(s):
            if c == '[':
                stack.append(NestedInteger())
            elif c == '-':
                sign = -1
            elif c.isdigit():
                num = num * 10 + int(c)
            elif c == ',' or c == ']':
                if s[i-1].isdigit():
                    stack[-1].add(NestedInteger(sign * num))
                num = 0
                sign = 1
                if c == ']':
                    if len(stack) > 1:
                        top = stack.pop()
                        stack[-1].add(top)

        return stack[0]