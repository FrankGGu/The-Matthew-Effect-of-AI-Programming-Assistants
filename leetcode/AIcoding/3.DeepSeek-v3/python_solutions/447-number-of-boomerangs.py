class Solution:
    def numberOfBoomerangs(self, points: List[List[int]]) -> int:
        res = 0
        for p in points:
            dist_map = {}
            for q in points:
                dx = p[0] - q[0]
                dy = p[1] - q[1]
                dist = dx * dx + dy * dy
                dist_map[dist] = dist_map.get(dist, 0) + 1
            for d in dist_map:
                res += dist_map[d] * (dist_map[d] - 1)
        return res