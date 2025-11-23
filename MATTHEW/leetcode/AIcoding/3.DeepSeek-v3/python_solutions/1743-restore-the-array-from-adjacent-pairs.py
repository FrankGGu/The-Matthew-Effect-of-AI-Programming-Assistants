class Solution:
    def restoreArray(self, adjacentPairs: List[List[int]]) -> List[int]:
        from collections import defaultdict

        graph = defaultdict(list)
        for u, v in adjacentPairs:
            graph[u].append(v)
            graph[v].append(u)

        root = None
        for num in graph:
            if len(graph[num]) == 1:
                root = num
                break

        res = []
        stack = [(root, None)]
        while stack:
            node, parent = stack.pop()
            res.append(node)
            for neighbor in graph[node]:
                if neighbor != parent:
                    stack.append((neighbor, node))

        return res