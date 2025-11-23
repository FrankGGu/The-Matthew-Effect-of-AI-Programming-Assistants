class Solution:
    def countInfectionSequences(self, n: int, sequences: List[List[int]]) -> int:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in sequences:
            graph[u].append(v)
            graph[v].append(u)

        def dfs(node, visited):
            visited.add(node)
            count = 1
            for neighbor in graph[node]:
                if neighbor not in visited:
                    count += dfs(neighbor, visited)
            return count

        visited = set()
        total_sequences = 0
        for i in range(1, n + 1):
            if i not in visited:
                total_sequences += dfs(i, visited)

        return total_sequences