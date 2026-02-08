class Solution:
    def minimumReverseOperations(self, n: int, p: int, banned: List[int], k: int) -> int:
        from collections import deque, defaultdict
        banned_set = set(banned)
        visited = [False] * n
        dist = [float('inf')] * n
        dist[p] = 0
        queue = deque([p])
        visited[p] = True

        while queue:
            current = queue.popleft()
            current_dist = dist[current]

            for i in range(max(0, current - k + 1), min(n - k + 1, current + 1)):
                if i not in banned_set and not visited[i]:
                    visited[i] = True
                    dist[i] = current_dist + 1
                    queue.append(i)

            for i in range(max(0, current + 1), min(n, current + k)):
                if i not in banned_set and not visited[i]:
                    visited[i] = True
                    dist[i] = current_dist + 1
                    queue.append(i)

        return min(dist[i] for i in range(n) if i not in banned_set) if any(dist[i] < float('inf') for i in range(n) if i not in banned_set) else -1