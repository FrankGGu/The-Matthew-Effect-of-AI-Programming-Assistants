class Solution:
    def fallingSquares(self, positions: List[List[int]]) -> List[int]:
        heights = []
        res = []
        max_height = 0

        def overlap(l1, r1, l2, r2):
            return l1 < r2 and l2 < r1

        for l, side in positions:
            r = l + side
            curr_height = 0
            for l2, r2, h in heights:
                if overlap(l, r, l2, r2):
                    curr_height = max(curr_height, h)

            heights.append((l, r, curr_height + side))
            max_height = max(max_height, curr_height + side)
            res.append(max_height)

        return res