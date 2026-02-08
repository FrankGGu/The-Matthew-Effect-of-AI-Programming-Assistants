class Solution:
    def leftmostBuildingQueries(self, heights: List[int], queries: List[List[int]]) -> List[int]:
        from bisect import bisect_left
        res = []
        n = len(heights)
        m = len(queries)
        for a, b in queries:
            x, y = min(a, b), max(a, b)
            if x == y or heights[x] < heights[y]:
                res.append(y)
            else:
                res.append(-1)
        return res