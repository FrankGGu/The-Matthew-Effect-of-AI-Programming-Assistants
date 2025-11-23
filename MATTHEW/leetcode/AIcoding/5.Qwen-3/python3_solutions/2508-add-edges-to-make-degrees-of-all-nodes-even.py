class Solution:
    def isPossible(self, n: int, edges: List[List[int]]) -> bool:
        degree = [0] * n
        for u, v in edges:
            degree[u] += 1
            degree[v] += 1

        odd = [i for i in range(n) if degree[i] % 2 == 1]

        if len(odd) == 0:
            return True
        if len(odd) == 2:
            return True
        return False