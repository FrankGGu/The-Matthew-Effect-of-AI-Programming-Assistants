class Solution:
    def maximumScore(self, a: List[int], b: List[int]) -> int:
        from itertools import permutations

        def score(x, y):
            return sum(1 for i in range(len(x)) if x[i] == y[i])

        max_total = 0
        for perm in permutations(range(len(b))):
            total = 0
            for i in range(len(a)):
                total += score(a[i], b[perm[i]])
            max_total = max(max_total, total)
        return max_total