from itertools import permutations

class Solution:
    def getDistances(self, pieces: list[list[int]]) -> list[int]:
        n = len(pieces)
        ans = [0] * n
        for perm in permutations(range(n)):
            dist = 0
            for i in range(n - 1):
                dist += abs(pieces[perm[i]][0] - pieces[perm[i+1]][0]) + abs(pieces[perm[i]][1] - pieces[perm[i+1]][1])
            for i in range(n):
                ans[perm[i]] += dist
        return ans