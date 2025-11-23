import bisect

class Solution:
    def kthNearestObstacleQueries(self, obstacles: list[list[int]], queries: list[list[int]]) -> list[int]:
        # 1. Coordinate Compression for Y-coordinates
        # Collect all unique y-coordinates from obstacles and queries
        all_y_coords = sorted(list(set([o[1] for o in obstacles] + [q[1] for q in queries])))

        # Handle edge case where there are no y-coordinates (empty obstacles and queries)
        if not all_y_coords:
            # If k_j is 0, the answer is 0. Otherwise, -1.
            # Since the problem asks for "exactly k_j obstacles", and there are no obstacles,
            # only k_j=0 can be satisfied (by x=0). If k_j > 0, it's -1.
            # The general binary search handles k_j=0 correctly to return 0.
            # If all_y_coords is empty, y_map[y_j] would fail.
            # So, if no y-coords, and k_j > 0, it's -1. If k_j == 0, it's 0.
            # Let's handle this in the loop for simplicity, by returning a default.
            # If queries can be empty, this is fine. If not, this is a problem.
            # Assuming queries are not empty.
            results = []
            for _, _, k_j in queries:
                if k_j == 0:
                    results.append(0)
                else:
                    results.append(-1)
            return results

        y_map = {y: i for i, y in enumerate(all_y_coords)}
        Y_MAX_COMPRESSED = len(all_y_coords) - 1 # Max index for compressed y-coordinates

        # Sort obstacles by x-coordinate. This order is crucial for building the PST.
        obstacles.sort()

        # Persistent Segment Tree Node definition
        class Node:
            def __init__(self, count=0, left=None, right=None):
                self.count = count
                self.left = left
                self.right = right

        # Function to update the Persistent Segment Tree
        # Creates a new node by adding 1 to the count at y_idx, copying unchanged parts from prev_node
        def update(prev_node: Node, start: int, end: int, y_idx: int) -> Node:
            new_node = Node(prev_node.count + 1)
            if start == end: # Leaf node
                return new_node

            mid = (start + end) // 2
            if y_idx <= mid:
                # If y_idx is in the left child's range, update left, copy right
                new_node.left = update(prev_node.left if prev_node.left else Node(), start, mid, y_idx)
                new_node.right = prev_node.right
            else:
                # If y_idx is in the right child's range, update right, copy left
                new_node.left = prev_node.left
                new_node.right = update(prev_node.right if prev_node.right else Node(), mid + 1, end, y_idx)
            return new_node

        # Function to query the count of obstacles with compressed y-coordinate <= query_y_end
        def query_pst(node: Node, start: int, end: int, query_y_end: int) -> int:
            if not node or start > query_y_end: # No node or segment range is entirely beyond query range
                return 0
            if end <= query_y_end: # Segment range is fully within query range
                return node.count

            mid = (start + end) // 2
            res = query_pst(node.left, start, mid, query_y_end)
            if query_y_end > mid: # Only query right child if its range overlaps with query_y_end
                res += query_pst(node.right, mid + 1, end, query_y_end)
            return res

        # Build the Persistent Segment Tree
        # roots[i] stores the root of the PST after processing i obstacles
        roots = [Node()] # roots[0] is an empty tree (0 obstacles processed)
        for x_i, y_i in obstacles:
            compressed_y = y_map[y_i]
            # Create a new version of the tree by adding the current obstacle
            roots.append(update(roots[-1], 0, Y_MAX_COMPRESSED, compressed_y))

        results = [-1] * len(queries)

        # Process each query
        for j in range(len(queries)):
            # x_j from queries[j] is ignored as per problem statement interpretation
            _, y_j, k_j = queries[j]
            compressed_y_q = y_map[y_j]

            # Binary search for the smallest `ans_root_idx` (version of PST)
            # such that the count of obstacles with y_i <= y_j is at least k_j.
            # `ans_root_idx` corresponds to the number of obstacles considered.
            low = 0 # Corresponds to roots[0] (0 obstacles)
            high = len(obstacles) # Corresponds to roots[len(obstacles)] (all obstacles)
            ans_root_idx = -1 # Stores the best candidate root index

            while low <= high:
                mid_root_idx = (low + high) // 2

                # Count obstacles with y_i <= y_j using the segment tree at mid_root_idx version
                count = query_pst(roots[mid_root_idx], 0, Y_MAX_COMPRESSED, compressed_y_q)

                if count >= k_j:
                    ans_root_idx = mid_root_idx
                    high = mid_root_idx - 1
                else:
                    low = mid_root_idx + 1

            # After binary search, ans_root_idx is the smallest index such that roots[ans_root_idx]
            # has at least k_j obstacles satisfying the y-condition.
            if ans_root_idx != -1:
                current_count = query_pst(roots[ans_root_idx], 0, Y_MAX_COMPRESSED, compressed_y_q)

                if current_count == k_j:
                    if ans_root_idx == 0:
                        # If ans_root_idx is 0, it means k_j must be 0, and 0 obstacles satisfy it.
                        # The minimum x-coordinate for 0 obstacles is 0.
                        results[j] = 0
                    else:
                        # The x-coordinate corresponds to the (ans_root_idx - 1)-th obstacle
                        # in the sorted `obstacles` list.
                        results[j] = obstacles[ans_root_idx - 1][0]
                else:
                    # current_count > k_j, meaning at this X, there are more than k_j obstacles.
                    # Since ans_root_idx is minimal, any smaller X (fewer obstacles) would yield < k_j.
                    # Thus, no X exists for *exactly* k_j obstacles.
                    results[j] = -1
            else:
                # ans_root_idx is -1, meaning even with all obstacles, the count was less than k_j.
                results[j] = -1

        return results