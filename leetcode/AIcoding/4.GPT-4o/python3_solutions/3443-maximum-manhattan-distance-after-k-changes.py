class Solution:
    def maxManhattanDistance(self, A: List[List[int]], K: int) -> int:
        n = len(A)
        max_dist = 0

        for i in range(n):
            for j in range(n):
                for x in range(n):
                    for y in range(n):
                        if abs(i - x) + abs(j - y) <= K:
                            max_dist = max(max_dist, abs(A[i][j] - A[x][y]))

        return max_dist