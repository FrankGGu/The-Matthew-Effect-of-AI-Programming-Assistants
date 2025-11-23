class Solution:
    def minimumCost(self, m: int, n: int, horizontalCut: list[int], verticalCut: list[int]) -> int:
        horizontalCut.sort(reverse=True)
        verticalCut.sort(reverse=True)

        total_cost = 0
        h_pieces = 1  # Number of horizontal segments (rows)
        v_pieces = 1  # Number of vertical segments (columns)

        h_idx = 0
        v_idx = 0

        while h_idx < len(horizontalCut) or v_idx < len(verticalCut):
            if h_idx < len(horizontalCut) and (v_idx == len(verticalCut) or horizontalCut[h_idx] >= verticalCut[v_idx]):
                # Make a horizontal cut
                total_cost += horizontalCut[h_idx] * v_pieces
                h_pieces += 1
                h_idx += 1
            else:
                # Make a vertical cut
                total_cost += verticalCut[v_idx] * h_pieces
                v_pieces += 1
                v_idx += 1

        return total_cost