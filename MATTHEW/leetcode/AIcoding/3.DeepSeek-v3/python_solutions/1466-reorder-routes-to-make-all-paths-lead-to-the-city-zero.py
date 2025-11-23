class Solution:
    def minReorder(self, n: int, connections: List[List[int]]) -> int:
        graph = defaultdict(list)
        roads = set()
        for u, v in connections:
            graph[u].append(v)
            graph[v].append(u)
            roads.add((u, v))

        res = 0
        stack = [(0, -1)]
        while stack:
            node, parent = stack.pop()
            for neighbor in graph[node]:
                if neighbor == parent:
                    continue
                if (node, neighbor) in roads:
                    res += 1
                stack.append((neighbor, node))
        return res