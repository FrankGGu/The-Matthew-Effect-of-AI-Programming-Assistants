class Solution:
    def distanceLimitedPathsExist(self, n: int, edgeList: List[List[int]], queries: List[List[int]]) -> List[bool]:
        edgeList.sort(key=lambda x: x[2])
        queries = sorted(((limit, idx) for idx, (u, v, limit) in enumerate(queries)), key=lambda x: x[0])
        parent = list(range(n))

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        result = [False] * len(queries)
        j = 0

        for limit, idx in queries:
            while j < len(edgeList) and edgeList[j][2] < limit:
                u, v = edgeList[j][0], edgeList[j][1]
                parent[find(u)] = find(v)
                j += 1
            result[idx] = find(queries[idx][1]) == find(queries[idx][0])

        return result