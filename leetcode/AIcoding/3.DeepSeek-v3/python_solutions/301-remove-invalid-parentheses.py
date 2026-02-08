from collections import deque

class Solution:
    def removeInvalidParentheses(self, s: str) -> List[str]:
        def is_valid(s):
            count = 0
            for c in s:
                if c == '(':
                    count += 1
                elif c == ')':
                    count -= 1
                    if count < 0:
                        return False
            return count == 0

        queue = deque([s])
        visited = set([s])
        found = False
        res = []

        while queue:
            current = queue.popleft()
            if is_valid(current):
                res.append(current)
                found = True

            if found:
                continue

            for i in range(len(current)):
                if current[i] not in '()':
                    continue
                next_str = current[:i] + current[i+1:]
                if next_str not in visited:
                    visited.add(next_str)
                    queue.append(next_str)

        return res if res else ['']