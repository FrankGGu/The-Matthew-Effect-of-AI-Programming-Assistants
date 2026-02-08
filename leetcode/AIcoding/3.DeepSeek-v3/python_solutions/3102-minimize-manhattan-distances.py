class Solution:
    def minimumDistance(self, points: List[List[int]]) -> int:
        def max_manhattan(points, exclude):
            max1 = max2 = -float('inf')
            min1 = min2 = float('inf')
            max1_i = max2_i = min1_i = min2_i = -1
            for i, (x, y) in enumerate(points):
                if i == exclude:
                    continue
                s = x + y
                d = x - y
                if s > max1:
                    max1 = s
                    max1_i = i
                if s < min1:
                    min1 = s
                    min1_i = i
                if d > max2:
                    max2 = d
                    max2_i = i
                if d < min2:
                    min2 = d
                    min2_i = i
            return max(max1 - min1, max2 - min2)

        max1 = max2 = -float('inf')
        min1 = min2 = float('inf')
        max1_i = max2_i = min1_i = min2_i = -1
        for i, (x, y) in enumerate(points):
            s = x + y
            d = x - y
            if s > max1:
                max1 = s
                max1_i = i
            if s < min1:
                min1 = s
                min1_i = i
            if d > max2:
                max2 = d
                max2_i = i
            if d < min2:
                min2 = d
                min2_i = i

        candidates = {max1_i, min1_i, max2_i, min2_i}
        res = float('inf')
        for candidate in candidates:
            res = min(res, max_manhattan(points, candidate))
        return res