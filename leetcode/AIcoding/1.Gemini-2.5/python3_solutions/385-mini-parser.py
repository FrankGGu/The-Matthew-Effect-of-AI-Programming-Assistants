class NestedInteger:
   def __init__(self, value=None):
       """
       If value is specified, this NestedInteger holds a single integer, otherwise it holds an empty nested list.
       """

   def isInteger(self):
       """
       @return True if this NestedInteger holds a single integer, rather than a nested list.
       :rtype bool
       """

   def add(self, elem):
       """
       Add a nested integer elem to its nested list.
       :rtype void
       """

   def getInteger(self):
       """
       @return the single integer that this NestedInteger holds, if it holds a single integer
       Return None if this NestedInteger holds a nested list
       :rtype int
       """

   def getList(self):
       """
       @return the nested list that this NestedInteger holds, if it holds a nested list
       Return an empty list if this NestedInteger holds a single integer
       :rtype List[NestedInteger]
       """

class Solution:
    def deserialize(self, s: str) -> NestedInteger:
        if s[0] != '[':
            return NestedInteger(int(s))

        stack = []
        current_num_str = ""
        root_ni = None

        for char in s:
            if char == '[':
                new_list_ni = NestedInteger()
                if root_ni is None:
                    root_ni = new_list_ni
                if stack:
                    stack[-1].add(new_list_ni)
                stack.append(new_list_ni)
            elif char.isdigit() or char == '-':
                current_num_str += char
            elif char == ',' or char == ']':
                if current_num_str:
                    num_val = int(current_num_str)
                    num_ni = NestedInteger(num_val)
                    stack[-1].add(num_ni)
                    current_num_str = ""

                if char == ']':
                    stack.pop()

        return root_ni