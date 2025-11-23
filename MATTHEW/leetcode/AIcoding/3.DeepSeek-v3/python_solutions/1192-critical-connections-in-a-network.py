class Solution:
    def criticalConnections(self, n: int, connections: List[List[int]]) -> List[List[int]]:
        graph = defaultdict(list)
        for u, v in connections:
            graph[u].append(v)
            graph[v].append(u)

        disc = [0] * n
        low = [0] * n
        time = [1]
        res = []

        def dfs(curr, prev):
            disc[curr] = low[curr] = time[0]
            time[0] += 1
            for neighbor in graph[curr]:
                if not disc[neighbor]:
                    dfs(neighbor, curr)
                    low[curr] = min(low[curr], low[neighbor])
                elif neighbor != prev:
                    low[curr] = min(low[curr], disc[neighbor])
                if low[neighbor] > disc[curr]:
                    res.append([curr, neighbor])

        dfs(0, -1)
        return res