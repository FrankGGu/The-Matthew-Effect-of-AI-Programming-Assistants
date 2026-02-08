from itertools import permutations

class Solution:
    def shortestSuperstring(self, A: list[str]) -> str:
        def overlap(s1, s2):
            for i in range(1, min(len(s1), len(s2)) + 1):
                if s1[-i:] == s2[:i]:
                    return i
            return 0

        def solve(perm):
            res = perm[0]
            for i in range(1, len(perm)):
                o = overlap(res, perm[i])
                res += perm[i][o:]
            return res

        shortest = None
        for perm in permutations(A):
            s = solve(perm)
            if shortest is None or len(s) < len(shortest):
                shortest = s
        return shortest