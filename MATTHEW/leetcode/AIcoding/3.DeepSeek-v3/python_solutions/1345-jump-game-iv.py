from collections import deque

class Solution:
    def minJumps(self, arr: List[int]) -> int:
        if len(arr) == 1:
            return 0

        value_indices = {}
        for i, num in enumerate(arr):
            if num in value_indices:
                value_indices[num].append(i)
            else:
                value_indices[num] = [i]

        visited = [False] * len(arr)
        queue = deque()
        queue.append(0)
        visited[0] = True
        steps = 0

        while queue:
            size = len(queue)
            for _ in range(size):
                current = queue.popleft()
                if current == len(arr) - 1:
                    return steps

                # Check left neighbor
                if current - 1 >= 0 and not visited[current - 1]:
                    visited[current - 1] = True
                    queue.append(current - 1)

                # Check right neighbor
                if current + 1 < len(arr) and not visited[current + 1]:
                    visited[current + 1] = True
                    queue.append(current + 1)

                # Check same value indices
                if arr[current] in value_indices:
                    for neighbor in value_indices[arr[current]]:
                        if neighbor != current and not visited[neighbor]:
                            visited[neighbor] = True
                            queue.append(neighbor)
                    del value_indices[arr[current]]
            steps += 1

        return -1