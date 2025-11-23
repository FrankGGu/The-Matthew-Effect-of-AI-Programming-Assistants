from collections import deque

class Solution:
    def kSimilarity(self, A: str, B: str) -> int:
        if A == B:
            return 0

        def neighbors(s):
            s = list(s)
            for i in range(len(s)):
                if s[i] != B[i]:
                    for j in range(i + 1, len(s)):
                        if s[j] == B[i] and s[j] != B[j]:
                            s[i], s[j] = s[j], s[i]
                            yield ''.join(s)
                            s[i], s[j] = s[j], s[i]
                    break

        queue = deque([A])
        visited = {A}
        steps = 0

        while queue:
            for _ in range(len(queue)):
                current = queue.popleft()
                if current == B:
                    return steps
                for neighbor in neighbors(current):
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)
            steps += 1

        return -1