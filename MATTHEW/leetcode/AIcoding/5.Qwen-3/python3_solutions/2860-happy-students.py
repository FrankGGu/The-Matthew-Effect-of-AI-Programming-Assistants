class Solution:
    def unhappyFriends(self, n: int, trust: List[List[int]]) -> int:
        rank = [0] * n
        for i in range(n):
            for j in range(n):
                if i != j:
                    rank[j] = trust[i].index(j)

        visited = [False] * n
        for i in range(n):
            for j in range(1, n):
                if rank[trust[i][j]] < rank[i]:
                    visited[i] = True
                    break

        return sum(visited)