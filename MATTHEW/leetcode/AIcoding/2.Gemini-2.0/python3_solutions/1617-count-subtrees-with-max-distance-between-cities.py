from collections import defaultdict

class Solution:
    def countSubtrees(self, n: int, edges: list[list[int]]) -> list[int]:
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        def bfs(start, mask):
            q = [(start, 0)]
            visited = {start}
            max_dist = 0
            farthest_node = start

            while q:
                node, dist = q.pop(0)

                if dist > max_dist:
                    max_dist = dist
                    farthest_node = node

                for neighbor in adj[node]:
                    if (1 << (neighbor - 1)) & mask and neighbor not in visited:
                        q.append((neighbor, dist + 1))
                        visited.add(neighbor)

            return farthest_node, max_dist, len(visited)

        def get_diameter(start, mask):
            node1, _, count = bfs(start, mask)
            node2, diameter, count2 = bfs(node1, mask)

            if count != count2:
                return -1

            return diameter

        result = [0] * n

        for mask in range(1, 2**n):
            start_node = -1
            count = 0
            for i in range(n):
                if (mask >> i) & 1:
                    start_node = i + 1
                    count += 1

            diameter = get_diameter(start_node, mask)
            if diameter > 0:
                result[diameter - 1] += 1

        return result