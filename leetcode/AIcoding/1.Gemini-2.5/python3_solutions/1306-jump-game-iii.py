from collections import deque

class Solution:
    def canReach(self, arr: list[int], start: int) -> bool:
        n = len(arr)

        q = deque()
        q.append(start)

        visited = [False] * n
        visited[start] = True

        while q:
            u = q.popleft()

            if arr[u] == 0:
                return True

            # Jump forward
            v1 = u + arr[u]
            if 0 <= v1 < n and not visited[v1]:
                visited[v1] = True
                q.append(v1)

            # Jump backward
            v2 = u - arr[u]
            if 0 <= v2 < n and not visited[v2]:
                visited[v2] = True
                q.append(v2)

        return False