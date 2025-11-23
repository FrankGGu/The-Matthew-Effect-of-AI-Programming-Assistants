class Solution:
    def findLexSmallestString(self, s: str, a: int, b: int) -> str:
        from collections import deque

        def rotate(s, b):
            return s[-b:] + s[:-b]

        visited = set()
        queue = deque([s])
        smallest = s

        while queue:
            current = queue.popleft()
            if current in visited:
                continue
            visited.add(current)
            smallest = min(smallest, current)
            if a > 0:
                new_str = ''.join(chr((ord(c) - ord('0') + a) % 10 + ord('0')) for c in current)
                queue.append(new_str)
            if b > 0:
                queue.append(rotate(current, b))

        return smallest