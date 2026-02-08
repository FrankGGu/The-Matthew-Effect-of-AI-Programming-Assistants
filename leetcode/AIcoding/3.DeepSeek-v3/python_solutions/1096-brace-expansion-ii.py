class Solution:
    def braceExpansionII(self, expression: str) -> List[str]:
        stack = []
        stack.append([])
        stack.append(set())

        for c in expression:
            if c == '{':
                stack.append([])
                stack.append(set())
            elif c == '}':
                union = set()
                while isinstance(stack[-1], set):
                    union |= stack.pop()
                stack.pop()  # pop the list
                if not stack[-1]:
                    stack[-1].append(union)
                else:
                    last = stack[-1][-1]
                    new_set = set()
                    for s1 in last:
                        for s2 in union:
                            new_set.add(s1 + s2)
                    stack[-1][-1] = new_set
            elif c == ',':
                stack[-1].update(stack[-2][-1])
                stack[-2].pop()
                stack[-2].append(set())
            else:
                if not stack[-2]:
                    stack[-2].append({c})
                else:
                    last = stack[-2][-1]
                    new_set = set()
                    for s in last:
                        new_set.add(s + c)
                    stack[-2][-1] = new_set

        if len(stack) > 2:
            stack[-1].update(stack[-2][-1])

        result = sorted(stack[-1])
        return result