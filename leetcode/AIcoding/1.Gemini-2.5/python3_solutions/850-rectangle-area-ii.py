from bisect import bisect_left

class SegmentTree:
    def __init__(self, y_coords):
        self.y_coords = y_coords
        self.N_y = len(y_coords) # Number of unique y-coordinates
        self.N_intervals = self.N_y - 1 # Number of elementary y-intervals

        if self.N_intervals <= 0:
            self.tree = []
            return

        # Each node in the tree represents a range of elementary intervals [node_interval_low, node_interval_high)
        # `count` stores how many active rectangles completely cover this node's y-range.
        # `length` stores the total length of covered y-intervals within this node's y-range.
        self.tree = [{'count': 0, 'length': 0} for _ in range(4 * self.N_intervals)]

    def _update(self, node_idx, node_interval_low, node_interval_high, query_interval_low, query_interval_high, val):
        # No overlap between current node's interval range and query interval range
        if node_interval_low >= query_interval_high or node_interval_high <= query_interval_low:
            return

        # Current node's interval range is completely contained within the query interval range
        if query_interval_low <= node_interval_low and node_interval_high <= query_interval_high:
            self.tree[node_idx]['count'] += val
        else:
            # Partial overlap, recurse on children
            mid_interval = (node_interval_low + node_interval_high) // 2
            self._update(2 * node_idx + 1, node_interval_low, mid_interval, query_interval_low, query_interval_high, val)
            self._update(2 * node_idx + 2, mid_interval, node_interval_high, query_interval_low, query_interval_high, val)

        # After updating children or base count, recalculate length for the current node
        self._recalculate_length(node_idx, node_interval_low, node_interval_high)

    def _recalculate_length(self, node_idx, node_interval_low, node_interval_high):
        if self.tree[node_idx]['count'] > 0:
            # If this node's y-range is covered by at least one active rectangle,
            # its length is the full length of its corresponding y-interval.
            # The y-interval is [y_coords[node_interval_low], y_coords[node_interval_high]].
            self.tree[node_idx]['length'] = self.y_coords[node_interval_high] - self.y_coords[node_interval_low]
        else:
            # If not covered, its length is the sum of its children's lengths.
            # If it's a leaf node (representing a single elementary interval), and not covered, its length is 0.
            if node_interval_low + 1 == node_interval_high: # This is a leaf node
                self.tree[node_idx]['length'] = 0
            else:
                self.tree[node_idx]['length'] = self.tree[2 * node_idx + 1]['length'] + self.tree[2 * node_idx + 2]['length']

    def update(self, y1, y2, type):
        if self.N_intervals <= 0:
            return

        # Find the indices in y_coords corresponding to y1 and y2.
        # These indices define the range of elementary intervals to update.
        # idx1 is the smallest index `i` such that y_coords[i] >= y1.
        # idx2 is the smallest index `j` such that y_coords[j] >= y2.
        # The elementary intervals [y_coords[k], y_coords[k+1]] that are affected
        # are those where k is in the range [idx1, idx2-1].
        # So the query range for elementary interval indices is [idx1, idx2).
        idx1 = bisect_left(self.y_coords, y1)
        idx2 = bisect_left(self.y_coords, y2)

        # The root node covers the full range of elementary intervals [0, self.N_intervals).
        self._update(0, 0, self.N_intervals, idx1, idx2, type)

    def query_total_length(self):
        if self.N_intervals <= 0:
            return 0
        # The total length of covered y-intervals is stored at the root node.
        return self.tree[0]['length']

class Solution:
    def rectangleArea(self, rectangles: list[list[int]]) -> int:
        MOD = 10**9 + 7

        events = []
        y_coords_set = set()

        for x1, y1, x2, y2 in rectangles:
            events.append((x1, 1, y1, y2)) # Type 1 for start of rectangle
            events.append((x2, -1, y1, y2)) # Type -1 for end of rectangle
            y_coords_set.add(y1)
            y_coords_set.add(y2)

        # Sort events by x-coordinate. If x-coordinates are equal, process start events before end events.
        events.sort()

        y_coords = sorted(list(y_coords_set))

        seg_tree = SegmentTree(y_coords)

        total_area = 0

        # Handle empty rectangles list case
        if not events:
            return 0

        prev_x = events[0][0] # Start with the x-coordinate of the first event

        for x, type, y1, y2 in events:
            # Calculate the area of the strip between prev_x and current x
            current_length = seg_tree.query_total_length()
            total_area = (total_area + current_length * (x - prev_x)) % MOD

            # Update the segment tree for the current event
            seg_tree.update(y1, y2, type)

            # Move prev_x to current x for the next iteration
            prev_x = x

        return total_area