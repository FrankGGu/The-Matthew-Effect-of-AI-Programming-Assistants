class Solution:
    def fallingSquares(self, positions: List[List[int]]) -> List[int]:
        intervals = []
        res = []
        max_height = 0

        for left, side in positions:
            right = left + side
            current_height = side
            for (l, r, h) in intervals:
                if not (right <= l or left >= r):
                    current_height = max(current_height, h + side)
            intervals.append((left, right, current_height))
            max_height = max(max_height, current_height)
            res.append(max_height)

        return res