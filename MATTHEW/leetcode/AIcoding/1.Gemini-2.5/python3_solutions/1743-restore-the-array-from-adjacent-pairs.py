from collections import defaultdict

class Solution:
    def restoreArray(self, adjacentPairs: list[list[int]]) -> list[int]:
        graph = defaultdict(list)
        for u, v in adjacentPairs:
            graph[u].append(v)
            graph[v].append(u)

        n = len(adjacentPairs) + 1
        result = [0] * n

        start_node = -1
        for node, neighbors in graph.items():
            if len(neighbors) == 1:
                start_node = node
                break

        result[0] = start_node
        result[1] = graph[start_node][0]

        for i in range(2, n):
            prev = result[i-2]
            curr = result[i-1]

            for neighbor in graph[curr]:
                if neighbor != prev:
                    result[i] = neighbor
                    break

        return result