import collections

class Solution:
    def shortestPathLength(self, graph: list[list[int]]) -> int:
        n = len(graph)

        if n == 1:
            return 0

        final_mask = (1 << n) - 1

        queue = collections.deque()
        visited_states = set()

        for i in range(n):
            initial_mask = (1 << i)
            queue.append((i, initial_mask, 0))
            visited_states.add((i, initial_mask))

        while queue:
            u, mask, dist = queue.popleft()

            if mask == final_mask:
                return dist

            for v in graph[u]:
                new_mask = mask | (1 << v)

                if (v, new_mask) not in visited_states:
                    visited_states.add((v, new_mask))
                    queue.append((v, new_mask, dist + 1))

        return -1 # Should not be reached based on problem constraints (graph is connected)