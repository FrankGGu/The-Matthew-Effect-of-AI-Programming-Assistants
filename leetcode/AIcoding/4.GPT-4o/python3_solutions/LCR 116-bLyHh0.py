class Solution:
    def findCircleNum(self, isConnected: List[List[int]]) -> int:
        def dfs(city):
            for neighbor in range(len(isConnected)):
                if isConnected[city][neighbor] == 1 and not visited[neighbor]:
                    visited[neighbor] = True
                    dfs(neighbor)

        visited = [False] * len(isConnected)
        provinces = 0

        for i in range(len(isConnected)):
            if not visited[i]:
                provinces += 1
                visited[i] = True
                dfs(i)

        return provinces