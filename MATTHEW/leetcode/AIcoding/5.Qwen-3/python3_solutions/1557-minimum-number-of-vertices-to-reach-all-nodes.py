class Solution:
    def findSmallestSetOfVertices(self, n: int, edges: List[List[int]]) -> int:
        in_degree = [0] * n
        for u, v in edges:
            in_degree[v] += 1
        result = []
        for i in range(n):
            if in_degree[i] == 0:
                result.append(i)
        return result