class Solution:
    def cycleLengthQueries(self, n: int, queries: List[List[int]]) -> List[int]:
        def lca(u, v):
            while u != v:
                if u > v:
                    u //= 2
                else:
                    v //= 2
            return u

        res = []
        for u, v in queries:
            depth = 0
            while u != v:
                if u > v:
                    u //= 2
                else:
                    v //= 2
                depth += 1
            res.append(depth)
        return res