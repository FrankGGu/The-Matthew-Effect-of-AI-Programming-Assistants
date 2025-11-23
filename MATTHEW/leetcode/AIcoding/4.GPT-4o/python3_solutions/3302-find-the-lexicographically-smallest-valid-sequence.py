class Solution:
    def findLexSmallestString(self, s: str, a: int, b: int) -> str:
        from collections import deque

        def rotate(s, b):
            return s[-b:] + s[:-b]

        n = len(s)
        visited = set()
        min_string = s
        queue = deque([s])

        while queue:
            curr = queue.popleft()
            if curr in visited:
                continue
            visited.add(curr)
            min_string = min(min_string, curr)
            new_str = ''.join(str((int(c) + a) % 10) for c in curr)
            if new_str not in visited:
                queue.append(new_str)
            if b > 0:
                rotated_str = rotate(curr, b)
                if rotated_str not in visited:
                    queue.append(rotated_str)

        return min_string