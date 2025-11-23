class Solution:
    def numberOfGoodPaths(self, vals: List[int], edges: List[List[int]]) -> int:
        from collections import defaultdict, Counter

        n = len(vals)
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        parent = list(range(n))
        def find(x):
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(x, y):
            px, py = find(x), find(y)
            if px != py:
                parent[py] = px

        val_to_nodes = defaultdict(list)
        for i in range(n):
            val_to_nodes[vals[i]].append(i)

        result = n
        for val in sorted(val_to_nodes.keys()):
            nodes = val_to_nodes[val]
            for node in nodes:
                for neighbor in graph[node]:
                    if vals[neighbor] <= val:
                        union(node, neighbor)
            groups = defaultdict(int)
            for node in nodes:
                groups[find(node)] += 1
            for count in groups.values():
                result += count * (count - 1) // 2
        return result