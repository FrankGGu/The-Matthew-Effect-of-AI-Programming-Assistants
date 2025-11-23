class Solution:
    def countVisitedNodes(self, edges: List[int]) -> List[int]:
        n = len(edges)
        res = [0] * n
        visited = [False] * n

        for i in range(n):
            if not visited[i]:
                path = []
                current = i
                while True:
                    if visited[current]:
                        if current in path:
                            idx = path.index(current)
                            cycle = path[idx:]
                            cycle_length = len(cycle)
                            for node in cycle:
                                res[node] = cycle_length
                        break
                    visited[current] = True
                    path.append(current)
                    current = edges[current]

        for i in range(n):
            if res[i] == 0:
                stack = []
                current = i
                while res[current] == 0:
                    stack.append(current)
                    current = edges[current]
                length = res[current]
                while stack:
                    node = stack.pop()
                    length += 1
                    res[node] = length

        return res