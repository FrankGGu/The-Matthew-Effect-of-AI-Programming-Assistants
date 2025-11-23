class Solution:
    def findCircleNum(self, isConnected: list[list[int]]) -> int:
        n = len(isConnected)
        visited = [False] * n
        num_provinces = 0

        def dfs(city_index):
            visited[city_index] = True
            for neighbor_index in range(n):
                if isConnected[city_index][neighbor_index] == 1 and not visited[neighbor_index]:
                    dfs(neighbor_index)

        for i in range(n):
            if not visited[i]:
                num_provinces += 1
                dfs(i)

        return num_provinces