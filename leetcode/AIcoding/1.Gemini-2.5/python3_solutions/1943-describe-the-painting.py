import collections

class Solution:
    def describeThePainting(self, paintings: list[list[int]]) -> list[list[int]]:
        diff = collections.defaultdict(int)
        for start, end, color in paintings:
            diff[start] += color
            diff[end] -= color

        sorted_points = sorted(diff.keys())

        result = []
        current_color_sum = 0
        last_point = None

        for p in sorted_points:
            if last_point is not None and p > last_point:
                if current_color_sum > 0:
                    result.append([last_point, p, current_color_sum])

            current_color_sum += diff[p]
            last_point = p

        return result