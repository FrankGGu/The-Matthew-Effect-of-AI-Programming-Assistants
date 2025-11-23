class Solution:
    def findLexSmallestString(self, s: str, a: int, b: int) -> str:
        n = len(s)
        visited = set()
        res = s
        from collections import deque
        q = deque([s])
        visited.add(s)
        while q:
            current = q.popleft()
            if current < res:
                res = current
            # Add operation
            add_list = list(current)
            for i in range(1, n, 2):
                add_list[i] = str((int(add_list[i]) + a) % 10)
            add_str = ''.join(add_list)
            if add_str not in visited:
                visited.add(add_str)
                q.append(add_str)
            # Rotate operation
            rotate_str = current[-b:] + current[:-b]
            if rotate_str not in visited:
                visited.add(rotate_str)
                q.append(rotate_str)
        return res