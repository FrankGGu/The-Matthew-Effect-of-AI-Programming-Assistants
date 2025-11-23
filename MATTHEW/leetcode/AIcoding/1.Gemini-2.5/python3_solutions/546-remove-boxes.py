import functools

class Solution:
    def removeBoxes(self, boxes: list[int]) -> int:
        n = len(boxes)

        @functools.lru_cache(None)
        def dp(i, j, k):
            if i > j:
                return 0

            # Optimization: Move 'j' leftwards as long as boxes[j] == boxes[j-1]
            # This groups contiguous boxes of the same color with the 'k' additional boxes.
            while j > i and boxes[j] == boxes[j-1]:
                j -= 1
                k += 1

            # Option 1: Remove boxes[j] along with k additional boxes of the same color.
            # This segment is boxes[i...j-1], and boxes[j] is removed with k other boxes.
            # Points gained: (k+1) * (k+1)
            res = dp(i, j - 1, 0) + (k + 1) * (k + 1)

            # Option 2: Find a box boxes[m] (i <= m < j) that has the same color as boxes[j].
            # Remove boxes[m+1...j-1] first.
            # Then, boxes[m] and boxes[j] (and the k additional boxes) can be removed together.
            # This effectively means boxes[j] is now an additional box for boxes[m].
            for m in range(i, j):
                if boxes[m] == boxes[j]:
                    res = max(res, dp(i, m, k + 1) + dp(m + 1, j - 1, 0))

            return res

        return dp(0, n - 1, 0)