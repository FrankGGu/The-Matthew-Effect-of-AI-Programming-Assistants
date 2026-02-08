class Solution:
    def findChampion(self, n: int, edges: List[List[int]]) -> int:
        indegree = [0] * n
        for _, v in edges:
            indegree[v] += 1

        champion_count = 0
        champion_index = -1

        for i in range(n):
            if indegree[i] == 0:
                champion_count += 1
                champion_index = i

        if champion_count == 1:
            return champion_index
        else:
            return -1