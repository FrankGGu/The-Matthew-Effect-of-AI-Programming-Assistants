import heapq

class Solution:
    def distanceLimitedPathsExist(self, n: int, edgeList: List[List[int]], queries: List[List[int]]) -> List[bool]:
        edgeList.sort(key=lambda x: x[2])

        queries_with_index = [(queries[i][0], queries[i][1], queries[i][2], i) for i in range(len(queries))]
        queries_with_index.sort(key=lambda x: x[2])

        parent = list(range(n))
        rank = [0] * n

        def find(i):
            if parent[i] == i:
                return i
            parent[i] = find(parent[i])
            return parent[i]

        def union(i, j):
            root_i = find(i)
            root_j = find(j)
            if root_i != root_j:
                if rank[root_i] < rank[root_j]:
                    parent[root_i] = root_j
                elif rank[root_i] > rank[root_j]:
                    parent[root_j] = root_i
                else:
                    parent[root_j] = root_i
                    rank[root_i] += 1

        edge_index = 0
        result = [False] * len(queries)

        for u, v, limit, index in queries_with_index:
            while edge_index < len(edgeList) and edgeList[edge_index][2] < limit:
                union(edgeList[edge_index][0], edgeList[edge_index][1])
                edge_index += 1

            if find(u) == find(v):
                result[index] = True

        return result