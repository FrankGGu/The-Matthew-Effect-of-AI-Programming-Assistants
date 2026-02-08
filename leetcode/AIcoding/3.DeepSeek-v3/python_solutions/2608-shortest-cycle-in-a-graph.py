import collections

class Solution:
    def findShortestCycle(self, n: int, edges: List[List[int]]) -> int:
        graph = collections.defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        min_cycle = float('inf')

        for i in range(n):
            distances = {i: 0}
            parent = {i: -1}
            queue = collections.deque([i])

            while queue:
                current = queue.popleft()
                for neighbor in graph[current]:
                    if neighbor not in distances:
                        distances[neighbor] = distances[current] + 1
                        parent[neighbor] = current
                        queue.append(neighbor)
                    elif parent[current] != neighbor and parent[neighbor] != current:
                        cycle_length = distances[current] + distances[neighbor] + 1
                        if cycle_length < min_cycle:
                            min_cycle = cycle_length

        return min_cycle if min_cycle != float('inf') else -1