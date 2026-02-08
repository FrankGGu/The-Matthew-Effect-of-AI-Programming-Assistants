class Solution:
    def restoreArray(self, adjacentPairs: list[list[int]]) -> list[int]:
        graph = {}
        for u, v in adjacentPairs:
            if u not in graph:
                graph[u] = []
            if v not in graph:
                graph[v] = []
            graph[u].append(v)
            graph[v].append(u)

        start = None
        for node, neighbors in graph.items():
            if len(neighbors) == 1:
                start = node
                break

        result = [start]
        visited = {start}

        while len(result) < len(graph):
            curr = result[-1]
            for neighbor in graph[curr]:
                if neighbor not in visited:
                    result.append(neighbor)
                    visited.add(neighbor)
                    break

        return result