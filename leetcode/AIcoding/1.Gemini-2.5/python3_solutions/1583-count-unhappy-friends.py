class Solution:
    def unhappyFriends(self, n: int, preferences: list[list[int]], pairs: list[list[int]]) -> int:
        pref_rank = [[0] * n for _ in range(n)]
        for i in range(n):
            for rank, friend in enumerate(preferences[i]):
                pref_rank[i][friend] = rank

        current_pair = [0] * n
        for x, y in pairs:
            current_pair[x] = y
            current_pair[y] = x

        unhappy_count = 0

        for x in range(n):
            y = current_pair[x]

            for u in preferences[x]:
                if u == y:
                    break

                v = current_pair[u]

                if pref_rank[u][x] < pref_rank[u][v]:
                    unhappy_count += 1
                    break

        return unhappy_count