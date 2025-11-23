from collections import defaultdict, deque

class Solution:
    def minJumps(self, arr: list[int]) -> int:
        n = len(arr)
        if n <= 1:
            return 0

        indices = defaultdict(list)
        for i, num in enumerate(arr):
            indices[num].append(i)

        visited = [False] * n
        visited[0] = True
        queue = deque([(0, 0)]) 

        while queue:
            index, steps = queue.popleft()

            if index == n - 1:
                return steps

            neighbors = []
            neighbors.append(index - 1)
            neighbors.append(index + 1)

            for neighbor_index in indices[arr[index]]:
                neighbors.append(neighbor_index)

            indices[arr[index]] = []

            for neighbor in neighbors:
                if 0 <= neighbor < n and not visited[neighbor]:
                    visited[neighbor] = True
                    queue.append((neighbor, steps + 1))
        return 0