from collections import deque

class Solution:
    def kSimilarity(self, A: str, B: str) -> int:
        if A == B:
            return 0
        queue = deque([(A, 0)])
        visited = set([A])
        while queue:
            current, steps = queue.popleft()
            if current == B:
                return steps
            i = 0
            while i < len(current) and current[i] == B[i]:
                i += 1
            for j in range(i + 1, len(current)):
                if current[j] == B[i] and current[j] != B[j]:
                    next_str = current[:i] + current[j] + current[i+1:j] + current[i] + current[j+1:]
                    if next_str not in visited:
                        visited.add(next_str)
                        queue.append((next_str, steps + 1))
        return -1