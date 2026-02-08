class Solution:
    def minimumLevels(self, points: list[int]) -> int:
        n = len(points)

        actual_points = [0] * n
        for i in range(n):
            if points[i] == 0:
                actual_points[i] = 1
            elif points[i] == 1:
                actual_points[i] = 1
            else: # points[i] == 2
                actual_points[i] = 2

        total_sum = sum(actual_points)

        current_sum_prefix = 0
        for k in range(1, n):
            current_sum_prefix += actual_points[k-1]

            current_sum_suffix = total_sum - current_sum_prefix

            if current_sum_prefix > current_sum_suffix:
                return k

        return -1