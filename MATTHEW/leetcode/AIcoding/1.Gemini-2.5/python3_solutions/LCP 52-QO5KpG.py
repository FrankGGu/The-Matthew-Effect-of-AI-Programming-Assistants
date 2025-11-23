import collections

class SegmentTree:
    def __init__(self, coords):
        # Sort and get unique coordinates
        self.coords = sorted(list(set(coords)))
        # Map original coordinates to compressed indices
        self.coord_to_idx = {coord: i for i, coord in enumerate(self.coords)}

        # The segment tree operates on elementary intervals defined by adjacent compressed coordinates.
        # If coords has N unique values, there are N-1 elementary intervals.
        # For example, coords = [1, 3, 6, 8] defines intervals [1,2], [3,5], [6,7].
        # These correspond to indices 0, 1, 2 in the segment tree's internal representation.
        self.n_intervals = len(self.coords) - 1

        # self.tree stores [colored_length, lazy_tag] for each node.
        # lazy_tag: 0 for uncolored, 1 for colored, -1 for no pending update.
        # A node's colored_length represents the total length of colored sub-segments within its range.
        self.tree = [[0, -1] for _ in range(4 * self.n_intervals)]

    def _pushdown(self, node_idx, start_idx, end_idx):
        # If there's a lazy tag on the current node, propagate it to children.
        if self.tree[node_idx][1] != -1:
            lazy_val = self.tree[node_idx][1]

            # Calculate children indices and mid-point
            left_child_idx = 2 * node_idx
            right_child_idx = 2 * node_idx + 1
            mid_idx = (start_idx + end_idx) // 2

            # Apply lazy tag to left child
            self.tree[left_child_idx][1] = lazy_val
            self.tree[left_child_idx][0] = lazy_val * (self.coords[mid_idx + 1] - self.coords[start_idx])

            # Apply lazy tag to right child
            self.tree[right_child_idx][1] = lazy_val
            self.tree[right_child_idx][0] = lazy_val * (self.coords[end_idx + 1] - self.coords[mid_idx + 1])

            # Clear current node's lazy tag after propagation
            self.tree[node_idx][1] = -1

    def _update_range(self, node_idx, current_start_idx, current_end_idx, query_L_idx, query_R_idx, color_val):
        # current_start_idx and current_end_idx are indices in self.coords, defining the current segment tree node's range.
        # query_L_idx and query_R_idx are indices in self.coords, defining the range to be updated.

        # If the current segment is completely outside the query range, do nothing.
        if current_start_idx > query_R_idx or current_end_idx < query_L_idx:
            return

        # If the current segment is completely inside the query range, apply the update directly.
        if query_L_idx <= current_start_idx and current_end_idx <= query_R_idx:
            self.tree[node_idx][1] = color_val
            self.tree[node_idx][0] = color_val * (self.coords[current_end_idx + 1] - self.coords[current_start_idx])
            return

        # If partial overlap, push lazy tag down and recurse on children.
        self._pushdown(node_idx, current_start_idx, current_end_idx)

        mid_idx = (current_start_idx + current_end_idx) // 2
        left_child_idx = 2 * node_idx
        right_child_idx = 2 * node_idx + 1

        self._update_range(left_child_idx, current_start_idx, mid_idx, query_L_idx, query_R_idx, color_val)
        self._update_range(right_child_idx, mid_idx + 1, current_end_idx, query_L_idx, query_R_idx, color_val)

        # After children are updated, update current node's value from children
        self.tree[node_idx][0] = self.tree[left_child_idx][0] + self.tree[right_child_idx][0]

    def update(self, L, R, color_val):
        # Map the original range [L, R] to compressed indices.
        # The segment tree operates on intervals [coords[i], coords[i+1]-1].
        # We need to find the index `idx_L` for `L` and `idx_R_plus_1` for `R+1`.
        # The intervals to update are from `idx_L` up to `idx_R_plus_1 - 1`.

        idx_L = self.coord_to_idx[L]
        idx_R_plus_1 = self.coord_to_idx[R + 1]

        # If the mapped range is empty, do nothing.
        if idx_L >= idx_R_plus_1:
            return

        # Call the recursive update function starting from the root (node_idx 1).
        # The root covers the entire range of elementary intervals [0, self.n_intervals - 1].
        self._update_range(1, 0, self.n_intervals - 1, idx_L, idx_R_plus_1 - 1, color_val)

    def get_total_colored_length(self):
        # The total colored length is stored at the root of the segment tree (node_idx 1).
        return self.tree[1][0]

class Solution:
    def solve(self, operations):
        # operations: list of [L, R, type]
        # type 1: color range [L, R]
        # type 0: uncolor range [L, R]

        # Collect all unique coordinates (L and R+1) from all operations.
        all_coords = set()
        for op in operations:
            L, R, _type = op
            all_coords.add(L)
            all_coords.add(R + 1)

        # Initialize the SegmentTree with the collected coordinates.
        segment_tree = SegmentTree(list(all_coords))

        # Perform each operation on the segment tree.
        for op in operations:
            L, R, _type = op
            segment_tree.update(L, R, _type)

        # After all operations, return the total length of colored segments.
        return segment_tree.get_total_colored_length()