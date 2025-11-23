from collections import defaultdict, deque

class Solution:
    def minJumps(self, arr: List[int]) -> int:
        if len(arr) <= 1:
            return 0

        graph = defaultdict(list)
        for i, num in enumerate(arr):
            graph[num].append(i)

        queue = deque([0])
        visited = {0}
        steps = 0

        while queue:
            for _ in range(len(queue)):
                idx = queue.popleft()
                if idx == len(arr) - 1:
                    return steps

                next_indices = graph[arr[idx]]
                next_indices.append(idx - 1)
                next_indices.append(idx + 1)

                for next_idx in next_indices:
                    if 0 <= next_idx < len(arr) and next_idx not in visited:
                        visited.add(next_idx)
                        queue.append(next_idx)

                graph[arr[idx]] = []
            steps += 1

        return -1