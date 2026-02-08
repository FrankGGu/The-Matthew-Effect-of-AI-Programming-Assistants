class Solution:
    def findChampion(self, n: int, edges: List[List[int]]) -> int:
        indegree = [0] * n
        for _, v in edges:
            indegree[v] += 1

        for i in range(n):
            if indegree[i] == 0:
                return i
        return -1