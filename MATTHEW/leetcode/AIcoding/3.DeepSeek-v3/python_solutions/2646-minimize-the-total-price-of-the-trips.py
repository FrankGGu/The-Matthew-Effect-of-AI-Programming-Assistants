class Solution:
    def minimumTotalPrice(self, n: int, edges: List[List[int]], price: List[int], trips: List[List[int]]) -> int:
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        count = [0] * n
        for start, end in trips:
            parent = [-1] * n
            stack = [start]
            parent[start] = start
            found = False
            while stack and not found:
                node = stack.pop()
                for neighbor in graph[node]:
                    if parent[neighbor] == -1:
                        parent[neighbor] = node
                        if neighbor == end:
                            found = True
                            break
                        stack.append(neighbor)
            path = []
            node = end
            while node != parent[node]:
                path.append(node)
                node = parent[node]
            path.append(start)
            for node in path:
                count[node] += 1

        memo = {}
        def dp(node, parent, can_halve):
            if (node, can_halve) in memo:
                return memo[(node, can_halve)]
            res = 0
            if can_halve:
                res_half = (price[node] // 2) * count[node]
                for neighbor in graph[node]:
                    if neighbor != parent:
                        res_half += dp(neighbor, node, False)
                res_no_half = price[node] * count[node]
                for neighbor in graph[node]:
                    if neighbor != parent:
                        res_no_half += dp(neighbor, node, True)
                res = min(res_half, res_no_half)
            else:
                res = price[node] * count[node]
                for neighbor in graph[node]:
                    if neighbor != parent:
                        res += dp(neighbor, node, True)
            memo[(node, can_halve)] = res
            return res

        return dp(0, -1, True)