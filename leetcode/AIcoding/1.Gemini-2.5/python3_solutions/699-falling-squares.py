class Solution:
    def fallingSquares(self, positions: list[list[int]]) -> list[int]:
        # Step 1: Coordinate compression
        # Collect all unique x-coordinates: start points and end points (exclusive) of squares
        coords = set()
        for left, side in positions:
            coords.add(left)
            coords.add(left + side)

        sorted_coords = sorted(list(coords))

        # Map original coordinates to compressed indices
        coord_to_idx = {x: i for i, x in enumerate(sorted_coords)}

        # The number of elementary intervals in the compressed space.
        # If sorted_coords has K elements, there are K-1 elementary intervals.
        # E.g., [x0, x1, x2] forms intervals [x0, x1-1] and [x1, x2-1].
        num_compressed_intervals = len(sorted_coords) - 1

        # If there are no intervals (e.g., empty positions list or only one unique coordinate),
        # the segment tree cannot be built. Handle this edge case.
        if num_compressed_intervals <= 0:
            return [0] * len(positions) if positions else []

        # Step 2: Segment tree initialization
        # tree[node] stores the maximum height in the range covered by node.
        # lazy[node] stores a pending update value for the range covered by node.
        # If lazy[node] > 0, it means the entire range should be at least lazy[node].
        # We use 1-based indexing for the segment tree nodes for convenience.
        tree = [0] * (4 * num_compressed_intervals)
        lazy = [0] * (4 * num_compressed_intervals)

        # Helper function to push lazy updates down the tree
        def push(node, start, end):
            if lazy[node] > 0:
                # Apply lazy value to current node's tree value
                # The actual max height in this range must be at least the lazy value
                tree[node] = max(tree[node], lazy[node])

                # If not a leaf node, propagate lazy value to children
                if start != end:
                    lazy[2 * node] = max(lazy[2 * node], lazy[node])
                    lazy[2 * node + 1] = max(lazy[2 * node + 1], lazy[node])

                # Clear current node's lazy tag after propagation
                lazy[node] = 0

        # Helper function to query the maximum height in a given range
        def query(node, start, end, query_l, query_r):
            # If current node's range is completely outside the query range
            if query_r < start or end < query_l:
                return 0

            # Apply any pending lazy updates before querying this node's value
            push(node, start, end)

            # If current node's range is fully within the query range
            if query_l <= start and end <= query_r:
                return tree[node]

            # Partial overlap, recurse on children
            mid = (start + end) // 2
            p1 = query(2 * node, start, mid, query_l, query_r)
            p2 = query(2 * node + 1, mid + 1, end, query_l, query_r)
            return max(p1, p2)

        # Helper function to update the height in a given range
        def update(node, start, end, update_l, update_r, val):
            # Apply any pending lazy updates before processing this node
            push(node, start, end)

            # If current node's range is completely outside the update range
            if update_r < start or end < update_l:
                return

            # If current node's range is fully within the update range
            if update_l <= start and end <= update_r:
                lazy[node] = max(lazy[node], val) # Update lazy tag for this node
                push(node, start, end) # Apply lazy to this node and propagate if it has children
                return

            # Partial overlap, recurse on children
            mid = (start + end) // 2
            update(2 * node, start, mid, update_l, update_r, val)
            update(2 * node + 1, mid + 1, end, update_l, update_r, val)

            # Update current node's tree value from its children's values
            # (after children have been updated and their lazy tags pushed)
            tree[node] = max(tree[2 * node], tree[2 * node + 1])

        # Step 3: Process each falling square
        results = []
        max_height_so_far = 0

        for left, side in positions:
            # Convert the square's interval [left, left + side - 1]
            # to compressed indices [query_l, query_r]
            query_l = coord_to_idx[left]
            query_r = coord_to_idx[left + side] - 1

            # Query the maximum height in the interval covered by the current square
            # The segment tree operates on indices from 0 to num_compressed_intervals - 1
            max_overlapped_height = query(1, 0, num_compressed_intervals - 1, query_l, query_r)

            # Calculate the new square's height
            current_square_height = max_overlapped_height + side

            # Update the segment tree with the new height for this interval
            update(1, 0, num_compressed_intervals - 1, query_l, query_r, current_square_height)

            # Update the overall maximum height seen so far
            max_height_so_far = max(max_height_so_far, current_square_height)
            results.append(max_height_so_far)

        return results