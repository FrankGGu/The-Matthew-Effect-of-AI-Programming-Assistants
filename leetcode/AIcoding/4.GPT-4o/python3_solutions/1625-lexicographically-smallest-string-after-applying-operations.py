class Solution:
    def findLexSmallestString(self, s: str, a: int, b: int) -> str:
        from collections import deque

        def rotate(s, b):
            return s[-b:] + s[:-b]

        seen = set()
        queue = deque([s])
        smallest = s

        while queue:
            current = queue.popleft()
            if current in seen:
                continue
            seen.add(current)
            smallest = min(smallest, current)
            new_str = ''.join(chr((ord(c) - ord('0') + a) % 10 + ord('0')) for c in current)
            if new_str not in seen:
                queue.append(new_str)
            if b > 0:
                rotated = rotate(current, b)
                if rotated not in seen:
                    queue.append(rotated)

        return smallest