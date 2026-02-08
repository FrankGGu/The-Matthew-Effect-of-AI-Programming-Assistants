import itertools

class Solution:
    def minimumDistance(self, points: List[List[int]]) -> int:
        def max_manhattan(points):
            max_sum = -float('inf')
            min_sum = float('inf')
            max_diff = -float('inf')
            min_diff = float('inf')
            for x, y in points:
                s = x + y
                d = x - y
                if s > max_sum:
                    max_sum = s
                if s < min_sum:
                    min_sum = s
                if d > max_diff:
                    max_diff = d
                if d < min_diff:
                    min_diff = d
            return max(max_sum - min_sum, max_diff - min_diff)

        max_sum = -float('inf')
        min_sum = float('inf')
        max_diff = -float('inf')
        min_diff = float('inf')
        candidates = []
        for x, y in points:
            s = x + y
            d = x - y
            if s > max_sum:
                max_sum = s
                candidates.append((x, y))
            if s < min_sum:
                min_sum = s
                candidates.append((x, y))
            if d > max_diff:
                max_diff = d
                candidates.append((x, y))
            if d < min_diff:
                min_diff = d
                candidates.append((x, y))
        candidates = list(set(candidates))

        min_max_dist = float('inf')
        for remove in candidates:
            remaining = [p for p in points if p != remove]
            current_max = max_manhattan(remaining)
            if current_max < min_max_dist:
                min_max_dist = current_max
        return min_max_dist