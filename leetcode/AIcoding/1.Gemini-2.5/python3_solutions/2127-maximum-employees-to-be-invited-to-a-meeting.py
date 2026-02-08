import sys

class Solution:
    def maximumInvitations(self, favorite: list[int]) -> int:
        n = len(favorite)

        # Increase recursion limit for DFS, as N can be up to 10^5
        sys.setrecursionlimit(n + 100) 

        # adj_rev stores incoming edges for building in-trees (reversed graph)
        adj_rev = [[] for _ in range(n)]
        for i in range(n):
            adj_rev[favorite[i]].append(i)

        # color:
        # 0 = unvisited
        # 1 = visiting (currently in the DFS recursion stack/path)
        # 2 = visited (fully processed, either part of a cycle or a tree leading to one)
        color = [0] * n

        # memo_in_tree_depth: memoization for get_max_in_tree_depth to avoid recomputing
        memo_in_tree_depth = {}

        # Function to calculate the maximum depth of an "in-tree" rooted at 'node'.
        # An in-tree consists of nodes that eventually lead to 'node' but are not part of the main cycle.
        # 'cycle_nodes_set' is used to prevent traversing into cycle nodes, ensuring we only consider branches.
        def get_max_in_tree_depth(node, cycle_nodes_set):
            if node in memo_in_tree_depth:
                return memo_in_tree_depth[node]

            max_d = 0
            for prev_node in adj_rev[node]:
                # Only consider nodes not part of the cycle itself
                if prev_node not in cycle_nodes_set:
                    max_d = max(max_d, 1 + get_max_in_tree_depth(prev_node, cycle_nodes_set))

            memo_in_tree_depth[node] = max_d
            return max_d

        max_cycle_len_sum = 0  # Sum of lengths of all cycles with length >= 3
        cycle2_in_tree_sum = 0 # Sum of (2 + in-tree lengths) for all cycles of length 2

        for i in range(n):
            if color[i] == 0: # If node 'i' has not been visited yet
                path = []
                curr = i
                depth_map = {} # Stores depth of nodes in the current DFS path
                d = 0

                # Traverse the graph following 'favorite' edges until a visited node is encountered
                while color[curr] == 0:
                    color[curr] = 1 # Mark as visiting
                    depth_map[curr] = d
                    path.append(curr)
                    curr = favorite[curr]
                    d += 1

                # After exiting the loop, 'curr' is a visited node.
                # If 'curr' is currently being visited (color == 1), it means we found a cycle.
                if color[curr] == 1: 
                    cycle_start_idx = depth_map[curr]
                    cycle_nodes = path[cycle_start_idx:]
                    cycle_len = len(cycle_nodes)

                    if cycle_len == 2:
                        # For a cycle of length 2 (u <-> v), we can invite u, v,
                        # and all nodes in the longest in-trees leading to u and v.
                        u, v = cycle_nodes[0], cycle_nodes[1]
                        cycle_nodes_set = set(cycle_nodes) # Convert to set for O(1) lookups

                        # Add 2 for the cycle nodes themselves, plus the max depths of their respective in-trees
                        cycle2_in_tree_sum += 2 + get_max_in_tree_depth(u, cycle_nodes_set) + get_max_in_tree_depth(v, cycle_nodes_set)
                    else: # For cycles of length >= 3, all members of the cycle can meet.
                        max_cycle_len_sum += cycle_len

                # Mark all nodes in the current path as fully processed (color 2)
                # This prevents re-processing them and ensures correct cycle detection for other paths.
                for node in path:
                    color[node] = 2

        # The maximum number of invited employees is the maximum of:
        # 1. The sum of lengths of all cycles with length >= 3 (these cycles are independent).
        # 2. The sum of (2 + in-tree lengths) for all cycles of length 2 (these are also independent).
        return max(max_cycle_len_sum, cycle2_in_tree_sum)