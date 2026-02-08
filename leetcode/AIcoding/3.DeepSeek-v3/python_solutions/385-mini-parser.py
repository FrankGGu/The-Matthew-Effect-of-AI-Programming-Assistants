class Solution:
    def deserialize(self, s: str) -> NestedInteger:
        if not s:
            return NestedInteger()
        if s[0] != '[':
            return NestedInteger(int(s))

        stack = []
        num = ''
        curr = None

        for ch in s:
            if ch == '[':
                new_list = NestedInteger()
                if stack:
                    stack[-1].add(new_list)
                stack.append(new_list)
            elif ch == ']' or ch == ',':
                if num:
                    stack[-1].add(NestedInteger(int(num)))
                    num = ''
                if ch == ']' and len(stack) > 1:
                    curr = stack.pop()
            else:
                num += ch

        return stack[0] if stack else curr