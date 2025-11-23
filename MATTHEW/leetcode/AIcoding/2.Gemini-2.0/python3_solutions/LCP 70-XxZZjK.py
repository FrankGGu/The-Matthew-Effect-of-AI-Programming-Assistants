class Solution:
    def solve(self, n: int, m: int, h: int, v: int, cost: list[list[int]]) -> int:
        source = 0
        sink = n + m + 1
        capacity = [[0] * (n + m + 2) for _ in range(n + m + 2)]
        total_cost = 0
        for i in range(1, n + 1):
            capacity[source][i] = h
        for j in range(1, m + 1):
            capacity[n + j][sink] = v
        for i in range(1, n + 1):
            for j in range(1, m + 1):
                capacity[i][n + j] = cost[i - 1][j - 1]
                total_cost += cost[i - 1][j - 1]

        def bfs():
            q = [(source, [source])]
            visited = set()
            while q:
                node, path = q.pop(0)
                if node == sink:
                    return path
                visited.add(node)
                for neighbor in range(n + m + 2):
                    if capacity[node][neighbor] > 0 and neighbor not in visited:
                        q.append((neighbor, path + [neighbor]))
            return None

        max_flow = 0
        while True:
            path = bfs()
            if not path:
                break

            flow = float('inf')
            for i in range(len(path) - 1):
                flow = min(flow, capacity[path[i]][path[i+1]])

            max_flow += flow

            for i in range(len(path) - 1):
                capacity[path[i]][path[i+1]] -= flow
                capacity[path[i+1]][path[i]] += flow

        return total_cost - max_flow