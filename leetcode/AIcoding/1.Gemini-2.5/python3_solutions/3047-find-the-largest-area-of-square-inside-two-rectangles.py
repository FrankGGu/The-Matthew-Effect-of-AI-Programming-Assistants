class Solution:
    def largestSquareArea(self, bottomLeft: list[list[int]], topRight: list[list[int]]) -> int:
        max_s = 0
        n = len(bottomLeft)

        for i in range(n):
            for j in range(i + 1, n):
                # Rectangle A: (x1, y1) is bottom-left, (x2, y2) is top-right
                x1, y1 = bottomLeft[i][0], bottomLeft[i][1]
                x2, y2 = topRight[i][0], topRight[i][1]

                # Rectangle B: (x3, y3) is bottom-left, (x4, y4) is top-right
                x3, y3 = bottomLeft[j][0], bottomLeft[j][1]
                x4, y4 = topRight[j][0], topRight[j][1]

                # Case 1: Bottom-left point (bx, by) from Rect A, Top-right point (tx, ty) from Rect B
                # For a square of side 's', we need:
                # bx in [x1, x2], by in [y1, y2]
                # tx in [x3, x4], ty in [y3, y4]
                # tx - bx = s  and ty - by = s

                # From tx - bx = s, we get bx = tx - s.
                # Substituting bx into its range: x1 <= tx - s <= x2
                # This implies: tx >= x1 + s  AND  tx <= x2 + s
                # Combined with tx's own range: x3 <= tx <= x4
                # We need an overlap for tx: max(x3, x1 + s) <= min(x4, x2 + s)
                # This inequality implies two conditions for s:
                # 1. x3 <= x2 + s  =>  s >= x3 - x2
                # 2. x1 + s <= x4  =>  s <= x4 - x1

                # Similarly for y-coordinates:
                # 1. y3 <= y2 + s  =>  s >= y3 - y2
                # 2. y1 + s <= y4  =>  s <= y4 - y1

                # All s values must also be non-negative.

                # Calculate the minimum required s and maximum allowed s for Case 1
                s_x_min_req_1 = x3 - x2
                s_x_max_allowed_1 = x4 - x1
                s_y_min_req_1 = y3 - y2
                s_y_max_allowed_1 = y4 - y1

                current_s_lower_1 = max(0, s_x_min_req_1, s_y_min_req_1)
                current_s_upper_1 = min(s_x_max_allowed_1, s_y_max_allowed_1)

                if current_s_lower_1 <= current_s_upper_1:
                    max_s = max(max_s, current_s_upper_1)

                # Case 2: Bottom-left point (bx, by) from Rect B, Top-right point (tx, ty) from Rect A
                # This is symmetric to Case 1, just swap the roles of Rect A and Rect B.
                # So, x1, y1, x2, y2 become bounds for tx, ty.
                # And x3, y3, x4, y4 become bounds for bx, by.
                # The conditions for s become:
                # x1 >= x4 + s  =>  s >= x1 - x4 (from original x3 - x2)
                # x3 + s <= x2  =>  s <= x2 - x3 (from original x4 - x1)
                # And similarly for y.

                s_x_min_req_2 = x1 - x4
                s_x_max_allowed_2 = x2 - x3
                s_y_min_req_2 = y1 - y4
                s_y_max_allowed_2 = y2 - y3

                current_s_lower_2 = max(0, s_x_min_req_2, s_y_min_req_2)
                current_s_upper_2 = min(s_x_max_allowed_2, s_y_max_allowed_2)

                if current_s_lower_2 <= current_s_upper_2:
                    max_s = max(max_s, current_s_upper_2)

        return max_s * max_s