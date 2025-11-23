class Solution:
    def processQueries(self, queries: List[int], m: int) -> List[int]:
        P = [i for i in range(1, m + 1)]
        res = []
        for q in queries:
            idx = P.index(q)
            res.append(idx)
            P.pop(idx)
            P.insert(0, q)
        return res