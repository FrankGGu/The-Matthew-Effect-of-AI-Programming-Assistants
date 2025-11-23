class Solution:
    def minimumCost(self, m: int, n: int, horizontalCut: list[int], verticalCut: list[int]) -> int:
        horizontalCut.sort(reverse=True)
        verticalCut.sort(reverse=True)

        total_cost = 0
        horizontal_pieces = 1
        vertical_pieces = 1

        h_ptr = 0
        v_ptr = 0

        while h_ptr < len(horizontalCut) or v_ptr < len(verticalCut):
            if h_ptr < len(horizontalCut) and (v_ptr == len(verticalCut) or horizontalCut[h_ptr] >= verticalCut[v_ptr]):
                total_cost += horizontalCut[h_ptr] * vertical_pieces
                horizontal_pieces += 1
                h_ptr += 1
            else:
                total_cost += verticalCut[v_ptr] * horizontal_pieces
                vertical_pieces += 1
                v_ptr += 1

        return total_cost