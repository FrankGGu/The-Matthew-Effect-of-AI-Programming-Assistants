class Solution:
    def findCircleNum(self, isConnected: List[List[int]]) -> int:
        n = len(isConnected)
        visited = [False] * n
        provinces = 0

        for i in range(n):
            if not visited[i]:
                provinces += 1
                stack = [i]
                visited[i] = True
                while stack:
                    node = stack.pop()
                    for neighbor in range(n):
                        if isConnected[node][neighbor] == 1 and not visited[neighbor]:
                            visited[neighbor] = True
                            stack.append(neighbor)

        return provinces