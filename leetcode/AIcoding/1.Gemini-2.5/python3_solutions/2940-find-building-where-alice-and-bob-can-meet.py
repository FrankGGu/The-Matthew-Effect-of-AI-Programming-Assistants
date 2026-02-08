class Solution:
    def findBuildingWhereAliceAndBobCanMeet(self, heights: list[int], queries: list[list[int]]) -> list[int]:
        n = len(heights)
        m = len(queries)
        ans = [-1] * m

        # Segment tree to store the maximum height in a given range.
        # tree[node] will store the maximum height in the segment represented by 'node'.
        # A size of 4*n is typically safe for a segment tree.
        tree = [0] * (4 * n)

        # Helper function to build the segment tree.
        # node: current node index in the tree array.
        # start, end: range [start, end] covered by the current node.
        def build(node, start, end):
            if start == end:
                # Leaf node: store the height of the building at this index.
                tree[node] = heights[start]
            else:
                mid = (start + end) // 2
                # Recursively build left and right children.
                build(2 * node, start, mid)
                build(2 * node + 1, mid + 1, end)
                # Internal node: store the maximum height of its children.
                tree[node] = max(tree[2 * node], tree[2 * node + 1])

        # Helper function to query the segment tree.
        # It finds the smallest index k in the range [query_L, query_R]
        # such that heights[k] is strictly greater than H_req.
        # node: current node index.
        # start, end: range [start, end] covered by the current node.
        # query_L, query_R: the target query range.
        # H_req: the required minimum height for building k.
        def query(node, start, end, query_L, query_R, H_req):
            # If the current segment [start, end] is completely outside the query range [query_L, query_R],
            # or if query_L is beyond query_R (empty query range), return n (indicating not found).
            if start > query_R or end < query_L or query_L > query_R:
                return n

            # If the maximum height in the current segment is not greater than H_req,
            # then no building in this segment can satisfy the height condition.
            if tree[node] <= H_req:
                return n

            # If it's a leaf node, and its height is > H_req (due to the previous check),
            # then this is the smallest index satisfying the conditions within its range.
            if start == end:
                return start

            # If it's an internal node and its max height is > H_req,
            # we need to search its children. Always try the left child first
            # to find the smallest possible index k.
            mid = (start + end) // 2
            res_left = query(2 * node, start, mid, query_L, query_R, H_req)

            if res_left != n:
                # If a valid index k is found in the left child, it's the smallest, so return it.
                return res_left
            else:
                # Otherwise, search in the right child.
                return query(2 * node + 1, mid + 1, end, query_L, query_R, H_req)

        # Build the segment tree for all buildings.
        build(1, 0, n - 1)

        # Process each query.
        for i in range(m):
            alice, bob = queries[i]

            # Condition 1: k > alice and k > bob. This means k must be strictly greater than max(alice, bob).
            # So, the search for k starts from max(alice, bob) + 1.
            start_search_idx = max(alice, bob) + 1

            # Condition 2: heights[k] > heights[alice] and heights[k] > heights[bob].
            # This means heights[k] must be strictly greater than max(heights[alice], heights[bob]).
            required_height = max(heights[alice], heights[bob])

            # Query the segment tree for the smallest index k.
            # The search range for k is [start_search_idx, n-1].
            result_k = query(1, 0, n - 1, start_search_idx, n - 1, required_height)

            # If a valid index k was found (i.e., not n), store it in the answer array.
            if result_k != n:
                ans[i] = result_k

        return ans