from collections import defaultdict

class Solution:
    def checkWays(self, pairs: list[list[int]]) -> int:
        graph = defaultdict(set)
        nodes = set()
        for u, v in pairs:
            graph[u].add(v)
            graph[v].add(u)
            nodes.add(u)
            nodes.add(v)

        root = None
        for node in nodes:
            if len(graph[node]) == len(nodes) - 1:
                root = node
                break

        if root is None:
            return 0

        def is_subtree(child, parent):
            if not graph[child].issubset(graph[parent]):
                return False
            return True

        res = 1
        for node in nodes:
            if node == root:
                continue
            neighbor = None
            for other in graph[node]:
                if len(graph[other]) < len(graph[node]):
                    neighbor = other
                    break
            if neighbor is None:
                return 0
            if not is_subtree(node, neighbor):
                return 0
            if len(graph[neighbor]) == len(graph[node]):
                res = 2

        return res