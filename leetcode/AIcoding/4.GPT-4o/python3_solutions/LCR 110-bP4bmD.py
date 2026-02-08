class Solution:
    def allPathsSourceTarget(self, graph: List[List[int]]) -> List[List[int]]:
        res = []
        def backtrack(node, path):
            if node == len(graph) - 1:
                res.append(path)
                return
            for neighbor in graph[node]:
                backtrack(neighbor, path + [neighbor])

        backtrack(0, [0])
        return res