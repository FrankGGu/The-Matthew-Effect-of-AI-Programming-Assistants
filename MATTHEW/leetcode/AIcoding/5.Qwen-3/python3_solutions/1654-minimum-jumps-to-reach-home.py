from collections import deque

class Solution:
    def minimumJump(self, code: str, k: int) -> int:
        n = len(code)
        visited = [False] * n
        queue = deque()
        queue.append((0, 0))
        visited[0] = True

        while queue:
            pos, steps = queue.popleft()
            if pos == n - 1:
                return steps
            next_pos = pos + k
            if next_pos < n and not visited[next_pos]:
                visited[next_pos] = True
                queue.append((next_pos, steps + 1))
            prev_pos = pos - 1
            if prev_pos >= 0 and not visited[prev_pos] and code[prev_pos] == '0':
                visited[prev_pos] = True
                queue.append((prev_pos, steps + 1))

        return -1