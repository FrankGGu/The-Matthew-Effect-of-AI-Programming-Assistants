class Solution:
    def gridGame(self, grid: List[List[int]]) -> float:
        top_row = grid[0]
        bottom_row = grid[1]

        prefix_top = [0] * (len(top_row) + 1)
        prefix_bottom = [0] * (len(bottom_row) + 1)

        for i in range(1, len(top_row) + 1):
            prefix_top[i] = prefix_top[i - 1] + top_row[i - 1]

        for i in range(1, len(bottom_row) + 1):
            prefix_bottom[i] = prefix_bottom[i - 1] + bottom_row[i - 1]

        max_score = float('inf')

        for i in range(len(top_row)):
            score = max(prefix_top[i], prefix_bottom[-1] - prefix_bottom[i + 1])
            max_score = min(max_score, score)

        return max_score / 2