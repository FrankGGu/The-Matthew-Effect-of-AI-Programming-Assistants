class Solution:
    def processQueries(self, queries: list[int], m: int) -> list[int]:
        p = list(range(1, m + 1))
        results = []

        for query in queries:
            idx = p.index(query)
            results.append(idx)

            val = p.pop(idx)
            p.insert(0, val)

        return results