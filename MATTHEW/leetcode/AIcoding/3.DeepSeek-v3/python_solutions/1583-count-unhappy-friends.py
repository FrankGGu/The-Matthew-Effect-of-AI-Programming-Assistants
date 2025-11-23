class Solution:
    def unhappyFriends(self, n: int, preferences: List[List[int]], pairs: List[List[int]]) -> int:
        pair_map = {}
        for x, y in pairs:
            pair_map[x] = y
            pair_map[y] = x

        rank = [[0] * n for _ in range(n)]
        for i in range(n):
            for j in range(len(preferences[i])):
                rank[i][preferences[i][j]] = j

        unhappy = set()

        for x in range(n):
            y = pair_map[x]
            for u in preferences[x]:
                if u == y:
                    break
                v = pair_map[u]
                if rank[u][x] < rank[u][v]:
                    unhappy.add(x)
                    break

        return len(unhappy)