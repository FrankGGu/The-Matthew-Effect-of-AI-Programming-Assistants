class Solution:
    def processQueries(self, queries: List[int], m: int) -> List[int]:
        P = list(range(1, m + 1))
        result = []
        for query in queries:
            index = P.index(query)
            result.append(index)
            P.pop(index)
            P.insert(0, query)
        return result