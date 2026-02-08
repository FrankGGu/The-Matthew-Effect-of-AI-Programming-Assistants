class Solution:
    def leftmostBuildingQueries(self, heights: list[int], queries: list[list[int]]) -> list[int]:
        n = len(heights)
        m = len(queries)
        ans = [-1] * m
        queries_with_idx = [(e[0], e[1], i) for i, e in enumerate(queries)]
        queries_with_idx.sort(key=lambda x: max(heights[x[0]], heights[x[1]]))

        buildings = list(range(n))
        buildings.sort(key=lambda i: heights[i])

        uf = {}
        def find(x):
            if x not in uf:
                uf[x] = x
            if uf[x] != x:
                uf[x] = find(uf[x])
            return uf[x]

        def union(x, y):
            root_x = find(x)
            root_y = find(y)
            if root_x != root_y:
                uf[root_x] = root_y

        building_idx = 0
        for a, b, i in queries_with_idx:
            max_height = max(heights[a], heights[b])
            while building_idx < n and heights[buildings[building_idx]] <= max_height:
                idx = buildings[building_idx]
                if idx > 0:
                    union(idx, idx - 1)
                if idx < n - 1:
                    union(idx, idx + 1)
                building_idx += 1

            if heights[a] <= heights[b]:
                a, b = b, a

            if heights[a] > heights[b] and a < b:
                ans[i] = a
            else:
                root_a = find(a)
                if root_a > a:
                    ans[i] = root_a
                else:
                    ans[i] = -1

        return ans