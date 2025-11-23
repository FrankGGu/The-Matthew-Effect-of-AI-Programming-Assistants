class Solution:
    def findLexSmallestString(self, s: str, a: int, b: int) -> str:
        n = len(s)
        visited = set()
        from collections import deque
        q = deque()
        q.append(s)
        visited.add(s)
        res = s

        while q:
            current = q.popleft()
            if current < res:
                res = current

            # Operation 1: add a to odd indices
            op1 = list(current)
            for i in range(1, n, 2):
                op1[i] = str((int(op1[i]) + a) % 10)
            op1 = ''.join(op1)
            if op1 not in visited:
                visited.add(op1)
                q.append(op1)

            # Operation 2: rotate right b positions
            op2 = current[-b:] + current[:-b]
            if op2 not in visited:
                visited.add(op2)
                q.append(op2)

        return res