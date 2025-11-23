from collections import deque

class Solution:
    def canReach(self, arr: list[int], start: int) -> bool:
        n = len(arr)
        q = deque([start])
        visited = [False] * n
        visited[start] = True

        while q:
            curr = q.popleft()
            if arr[curr] == 0:
                return True

            next_indices = [curr + arr[curr], curr - arr[curr]]
            for next_index in next_indices:
                if 0 <= next_index < n and not visited[next_index]:
                    q.append(next_index)
                    visited[next_index] = True

        return False