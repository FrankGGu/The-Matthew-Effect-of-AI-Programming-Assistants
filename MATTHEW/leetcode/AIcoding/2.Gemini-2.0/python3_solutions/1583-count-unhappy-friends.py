class Solution:
    def unhappyFriends(self, n: int, preferences: list[list[int]], pairs: list[list[int]]) -> int:
        pair_dict = {}
        for p1, p2 in pairs:
            pair_dict[p1] = p2
            pair_dict[p2] = p1

        unhappy_count = 0
        for x in range(n):
            y = pair_dict[x]

            x_pref = preferences[x]

            y_index = x_pref.index(y)

            for u_index in range(y_index):
                u = x_pref[u_index]
                v = pair_dict[u]

                u_pref = preferences[u]

                if u_pref.index(x) < u_pref.index(v):
                    unhappy_count += 1
                    break

        return unhappy_count