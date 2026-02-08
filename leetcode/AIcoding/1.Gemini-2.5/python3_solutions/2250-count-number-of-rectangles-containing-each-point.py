import bisect

class FenwickTree:
    def __init__(self, size):
        self.tree = [0] * size
        self.size = size

    def update(self, index, delta):
        while index < self.size:
            self.tree[index] += delta
            index += index & (-index)

    def query(self, index):
        s = 0
        while index > 0:
            s += self.tree[index]
            index -= index & (-index)
        return s

class Solution:
    def countRectangles(self, rectangles: list[list[int]], points: list[list[int]]) -> list[int]:
        rect_data = []
        for l, h in rectangles:
            rect_data.append((h, l))
        rect_data.sort(key=lambda x: x[0], reverse=True)

        point_data = []
        for i, (p, q) in enumerate(points):
            point_data.append((q, p, i))
        point_data.sort(key=lambda x: x[0], reverse=True)

        all_l_coords = sorted(list(set([r[0] for r in rectangles])))
        coord_to_idx = {val: i for i, val in enumerate(all_l_coords)}

        bit = FenwickTree(len(all_l_coords) + 1)

        ans = [0] * len(points)
        rect_ptr = 0

        for q, p, original_idx in point_data:
            while rect_ptr < len(rect_data) and rect_data[rect_ptr][0] >= q:
                l_val = rect_data[rect_ptr][1]
                l_idx = coord_to_idx[l_val]
                bit.update(l_idx + 1, 1)
                rect_ptr += 1

            upper_bound_idx = bisect.bisect_right(all_l_coords, p)

            count = bit.query(upper_bound_idx)
            ans[original_idx] = count

        return ans