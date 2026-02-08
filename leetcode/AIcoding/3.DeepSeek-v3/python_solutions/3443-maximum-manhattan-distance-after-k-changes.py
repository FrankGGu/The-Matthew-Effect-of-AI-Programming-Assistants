class Solution:
    def maxManhattanDistance(self, points: List[List[int]], k: int) -> int:
        n = len(points)
        if n == 0:
            return 0

        def get_max_diff():
            max_sum = -float('inf')
            min_sum = float('inf')
            max_diff = -float('inf')
            min_diff = float('inf')
            for x, y in points:
                current_sum = x + y
                current_diff = x - y
                if current_sum > max_sum:
                    max_sum = current_sum
                if current_sum < min_sum:
                    min_sum = current_sum
                if current_diff > max_diff:
                    max_diff = current_diff
                if current_diff < min_diff:
                    min_diff = current_diff
            return max(max_sum - min_sum, max_diff - min_diff)

        return get_max_diff()