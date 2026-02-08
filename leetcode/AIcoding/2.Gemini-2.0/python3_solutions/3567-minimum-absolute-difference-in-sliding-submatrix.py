from sortedcontainers import SortedList

class Solution:
    def minAbsoluteDifference(self, mat: List[List[int]], x: int) -> int:
        n = len(mat)
        ans = float('inf')
        for j in range(n - x):
            sl = SortedList()
            for i in range(n - x):
                for row in range(x + 1):
                    sl.add(mat[i + row][j])
                    sl.add(mat[i][j + x - row])

                for k in range(len(sl)):
                    if k > 0:
                        ans = min(ans, abs(sl[k] - sl[k - 1]))

                for row in range(x + 1):
                    sl.remove(mat[i + row][j])
                    sl.remove(mat[i][j + x - row])
        return ans