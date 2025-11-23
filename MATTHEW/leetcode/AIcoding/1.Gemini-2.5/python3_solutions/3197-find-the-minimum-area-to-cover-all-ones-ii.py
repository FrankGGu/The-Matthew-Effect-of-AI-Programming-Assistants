import math
from typing import List

class Solution:
    def minArea(self, grid: List[List[int]]) -> int:
        R, C = len(grid), len(grid[0])

        ones_coords = []
        for r in range(R):
            for c in range(C):
                if grid[r][c] == 1:
                    ones_coords.append((r, c))

        if not ones_coords:
            return 0 

        # Find the overall bounding box of all ones
        overall_min_r = math.inf
        overall_max_r = -math.inf
        overall_min_c = math.inf
        overall_max_c = -math.inf

        for r, c in ones_coords:
            overall_min_r = min(overall_min_r, r)
            overall_max_r = max(overall_max_r, r)
            overall_min_c = min(overall_min_c, c)
            overall_max_c = max(overall_max_c, c)

        # If there are 1 or 2 ones, they can be covered by a single rectangle
        # (and two effectively empty rectangles). The area would be that of their bounding box.
        if len(ones_coords) <= 2:
            return (overall_max_r - overall_min_r + 1) * (overall_max_c - overall_min_c + 1)

        # Helper function to calculate bounding box area for ones within a specified region
        # Returns math.inf if no ones are found in the region, indicating it cannot form a non-empty rectangle.
        def get_bbox_area(r1, c1, r2, c2):
            if r1 > r2 or c1 > c2: # Invalid region (e.g., start > end)
                return math.inf

            current_min_r = math.inf
            current_max_r = -math.inf
            current_min_c = math.inf
            current_max_c = -math.inf

            found_one_in_region = False
            for r, c in ones_coords:
                if r1 <= r <= r2 and c1 <= c <= c2:
                    found_one_in_region = True
                    current_min_r = min(current_min_r, r)
                    current_max_r = max(current_max_r, r)
                    current_min_c = min(current_min_c, c)
                    current_max_c = max(current_max_c, c)

            if not found_one_in_region:
                return math.inf # Indicate that this region has no ones

            return (current_max_r - current_min_r + 1) * (current_max_c - current_min_c + 1)

        # Helper function to find min area for two rectangles in a subregion
        # Returns math.inf if it's impossible to cover all ones in the subregion with two non-empty rectangles.
        def solve_two_rects(r1, c1, r2, c2):
            if r1 > r2 or c1 > c2:
                return math.inf

            min_area_two = math.inf

            # Try horizontal split: divides [r1, r2] into [r1, r_cut] and [r_cut+1, r2]
            for r_cut in range(r1, r2): 
                area1 = get_bbox_area(r1, c1, r_cut, c2)
                area2 = get_bbox_area(r_cut + 1, c1, r2, c2)
                if area1 != math.inf and area2 != math.inf:
                    min_area_two = min(min_area_two, area1 + area2)

            # Try vertical split: divides [c1, c2] into [c1, c_cut] and [c_cut+1, c2]
            for c_cut in range(c1, c2): 
                area1 = get_bbox_area(r1, c1, r2, c_cut)
                area2 = get_bbox_area(r1, c_cut + 1, r2, c2)
                if area1 != math.inf and area2 != math.inf:
                    min_area_two = min(min_area_two, area1 + area2)

            return min_area_two

        min_total_area = math.inf

        # Case 1: Three horizontal strips
        # Cuts at r1_cut and r2_cut divide the overall bounding box horizontally into 3 regions.
        # r1_cut is the last row of the first rectangle.
        # r2_cut is the last row of the second rectangle.
        for r1_cut in range(overall_min_r, overall_max_r - 1):
            for r2_cut in range(r1_cut + 1, overall_max_r):
                area1 = get_bbox_area(overall_min_r, overall_min_c, r1_cut, overall_max_c)
                area2 = get_bbox_area(r1_cut + 1, overall_min_c, r2_cut, overall_max_c)
                area3 = get_bbox_area(r2_cut + 1, overall_min_c, overall_max_r, overall_max_c)

                if area1 != math.inf and area2 != math.inf and area3 != math.inf:
                    min_total_area = min(min_total_area, area1 + area2 + area3)

        # Case 2: Three vertical strips
        # Cuts at c1_cut and c2_cut divide the overall bounding box vertically into 3 regions.
        # c1_cut is the last col of the first rectangle.
        # c2_cut is the last col of the second rectangle.
        for c1_cut in range(overall_min_c, overall_max_c - 1):
            for c2_cut in range(c1_cut + 1, overall_max_c):
                area1 = get_bbox_area(overall_min_r, overall_min_c, overall_max_r, c1_cut)
                area2 = get_bbox_area(overall_min_r, c1_cut + 1, overall_max_r, c2_cut)
                area3 = get_bbox_area(overall_min_r, c2_cut + 1, overall_max_r, overall_max_c)

                if area1 != math.inf and area2 != math.inf and area3 != math.inf:
                    min_total_area = min(min_total_area, area1 + area2 + area3)

        # Case 3: One rectangle + two rectangles (split by a single cut)
        # This covers L-shaped or T-shaped decompositions.

        # 3a: One horizontal cut, then the remaining part is covered by two rectangles.
        # r_cut is the last row of the first rectangle.
        for r_cut in range(overall_min_r, overall_max_r): 
            # Rect 1 is above r_cut, Rect 2 & 3 are below r_cut
            area1 = get_bbox_area(overall_min_r, overall_min_c, r_cut, overall_max_c)
            area23 = solve_two_rects(r_cut + 1, overall_min_c, overall_max_r, overall_max_c)
            if area1 != math.inf and area23 != math.inf:
                min_total_area = min(min_total_area, area1 + area23)

            # Rect 1 is below r_cut, Rect 2 & 3 are above r_cut
            area1 = get_bbox_area(r_cut + 1, overall_min_c, overall_max_r, overall_max_c)
            area23 = solve_two_rects(overall_min_r, overall_min_c, r_cut, overall_max_c)
            if area1 != math.inf and area23 != math.inf:
                min_total_area = min(min_total_area, area1 + area23)

        # 3b: One vertical cut, then the remaining part is covered by two rectangles.
        # c_cut is the last col of the first rectangle.
        for c_cut in range(overall_min_c, overall_max_c): 
            # Rect 1 is left of c_cut, Rect 2 & 3 are right of c_cut
            area1 = get_bbox_area(overall_min_r, overall_min_c, overall_max_r, c_cut)
            area23 = solve_two_rects(overall_min_r, c_cut + 1, overall_max_r, overall_max_c)
            if area1 != math.inf and area23 != math.inf:
                min_total_area = min(min_total_area, area1 + area23)

            # Rect 1 is right of c_cut, Rect 2 & 3 are left of c_cut
            area1 = get_bbox_area(overall_min_r, c_cut + 1, overall_max_r, overall_max_c)
            area23 = solve_two_rects(overall_min_r, overall_min_c, overall_max_r, c_cut)
            if area1 != math.inf and area23 != math.inf:
                min_total_area = min(min_total_area, area1 + area23)

        return min_total_area