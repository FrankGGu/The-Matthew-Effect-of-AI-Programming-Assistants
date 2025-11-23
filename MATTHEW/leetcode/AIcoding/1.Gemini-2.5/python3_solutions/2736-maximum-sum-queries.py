import bisect

class SegmentTree:
    def __init__(self, size):
        self.size = size
        # Initialize with -1, as sums can be positive and -1 is the default for no match
        self.tree = [-1] * (4 * size) 

    def update(self, node, start, end, idx, val):
        if start == end:
            # We want to store the maximum sum for this specific nums2 value
            self.tree[node] = max(self.tree[node], val)
            return

        mid = (start + end) // 2
        if start <= idx <= mid:
            self.update(2 * node, start, mid, idx, val)
        else:
            self.update(2 * node + 1, mid + 1, end, idx, val)

        # Propagate max up
        self.tree[node] = max(self.tree[2 * node], self.tree[2 * node + 1])

    def query(self, node, start, end, l, r):
        # If query range is completely outside current node's range
        if r < start or end < l:
            return -1 

        # If query range completely covers current node's range
        if l <= start and end <= r:
            return self.tree[node]

        # Partially overlapping, recurse
        mid = (start + end) // 2
        p1 = self.query(2 * node, start, mid, l, r)
        p2 = self.query(2 * node + 1, mid + 1, end, l, r)
        return max(p1, p2)

class Solution:
    def maximumSumQueries(self, nums1: list[int], nums2: list[int], queries: list[list[int]]) -> list[int]:
        n = len(nums1)
        m = len(queries)

        # 1. Prepare data points
        # Store (nums1[i], nums2[i], nums1[i] + nums2[i])
        data_points = []
        for i in range(n):
            data_points.append((nums1[i], nums2[i], nums1[i] + nums2[i]))

        # 2. Prepare query points
        # Store (x, y, original_index)
        query_points = []
        for i in range(m):
            query_points.append((queries[i][0], queries[i][1], i))

        # 3. Sort data points and query points
        # Sort by nums1[i] (or x) in descending order
        data_points.sort(key=lambda x: x[0], reverse=True)
        query_points.sort(key=lambda x: x[0], reverse=True)

        # 4. Coordinate compression for nums2 values
        # Collect all unique nums2 values
        unique_nums2 = sorted(list(set(num for _, num, _ in data_points)))
        # Map value to its compressed index
        val_to_compressed_idx = {val: i for i, val in enumerate(unique_nums2)}

        k = len(unique_nums2) # Number of unique nums2 values, this is the size for segment tree

        # 5. Initialize Segment Tree
        seg_tree = SegmentTree(k)

        # 6. Initialize results array
        ans = [-1] * m

        # 7. Two pointers for processing data and queries
        data_ptr = 0
        for x, y, original_idx in query_points:
            # Add all relevant data points (nums1[i] >= x) to the segment tree
            while data_ptr < n and data_points[data_ptr][0] >= x:
                n1, n2, s = data_points[data_ptr]
                compressed_n2_idx = val_to_compressed_idx[n2]
                seg_tree.update(1, 0, k - 1, compressed_n2_idx, s)
                data_ptr += 1

            # Find the compressed index for y (or the smallest value >= y)
            # bisect_left returns an insertion point which maintains sorted order
            compressed_y_idx = bisect.bisect_left(unique_nums2, y)

            # If compressed_y_idx is within bounds, query the segment tree
            if compressed_y_idx < k:
                ans[original_idx] = seg_tree.query(1, 0, k - 1, compressed_y_idx, k - 1)
            # Else, no nums2 value >= y exists that has been added, so result remains -1

        return ans