class Solution:
    def unhappyFriends(self, n: int, preferences: List[List[int]], pairs: List[List[int]]) -> int:
        preference_map = [None] * n
        for i in range(n):
            preference_map[i] = {preferences[i][j]: j for j in range(len(preferences[i]))}

        partner = [0] * n
        for a, b in pairs:
            partner[a] = b
            partner[b] = a

        unhappy_count = 0

        for a in range(n):
            b = partner[a]
            for c in preferences[a]:
                if c == b:
                    break
                if partner[c] != a and preference_map[c][a] < preference_map[c][partner[c]]:
                    unhappy_count += 1
                    break

        return unhappy_count