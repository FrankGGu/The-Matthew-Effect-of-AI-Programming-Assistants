import collections

class Solution:
    def maximizeSumOfWeights(self, n: int, weights: list[int], edges: list[list[int]]) -> int:
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        subtree_sum = [0] * n
        # max_subtree_val[u] stores the maximum sum of any single connected component (subtree)
        # that is entirely contained within the subtree rooted at u.
        max_subtree_val = [0] * n 

        # Global variable to store the maximum score found.
        # Initialize with a very small number, or with the largest single node weight.
        # The problem implies that total_sum is not a valid answer for n > 1.
        # For n=1, the answer is weights[0].
        # For n > 1, we must remove at least one edge, so total_sum is not achievable.
        # The lowest possible sum for a component is the minimum weight node.
        self.global_max_score = 0 if n > 1 else weights[0]

        # DFS Pass 1: Calculate subtree_sum and max_subtree_val for all nodes
        # max_subtree_val[u] = max(subtree_sum[x] for x in subtree rooted at u)
        def dfs1(u, p):
            current_subtree_sum = weights[u]
            current_max_subtree_val_in_u = weights[u] # Max subtree sum found so far within u's subtree

            for v in adj[u]:
                if v != p:
                    dfs1(v, u)
                    current_subtree_sum += subtree_sum[v]
                    current_max_subtree_val_in_u = max(current_max_subtree_val_in_u, max_subtree_val[v])

            subtree_sum[u] = current_subtree_sum
            max_subtree_val[u] = max(current_max_subtree_val_in_u, subtree_sum[u])

            # Update global_max_score with the maximum single component sum found so far.
            # We exclude subtree_sum[0] (total_sum) if n > 1, as it's not a valid answer.
            if n == 1 or u != 0:
                self.global_max_score = max(self.global_max_score, subtree_sum[u])

        dfs1(0, -1)

        total_sum = subtree_sum[0] # The sum of all weights in the tree

        # DFS Pass 2: Calculate max_outside_u_val and update global_max_score
        # max_outside_u_val is the maximum sum of any single connected component (subtree)
        # that is entirely outside the subtree rooted at u.
        def dfs2(u, p, max_outside_u_val):
            # Update global_max_score with the sum of two disjoint components:
            # one from u's subtree (max_subtree_val[u]) and one from outside u's subtree (max_outside_u_val).
            if n > 1: # Only consider two components if n > 1
                self.global_max_score = max(self.global_max_score, max_subtree_val[u] + max_outside_u_val)

            # Prepare max_outside_v_val for children v
            # This involves max_outside_u_val, the component (total_sum - subtree_sum[u]),
            # and max_subtree_val from siblings of v.

            children_max_subtree_vals = []
            for v_child in adj[u]:
                if v_child != p:
                    children_max_subtree_vals.append(max_subtree_val[v_child])

            prefix_max_subtree = [0] * len(children_max_subtree_vals)
            suffix_max_subtree = [0] * len(children_max_subtree_vals)

            if children_max_subtree_vals:
                prefix_max_subtree[0] = children_max_subtree_vals[0]
                for i in range(1, len(children_max_subtree_vals)):
                    prefix_max_subtree[i] = max(prefix_max_subtree[i-1], children_max_subtree_vals[i])

                suffix_max_subtree[-1] = children_max_subtree_vals[-1]
                for i in range(len(children_max_subtree_vals)-2, -1, -1):
                    suffix_max_subtree[i] = max(suffix_max_subtree[i+1], children_max_subtree_vals[i])

            child_idx = 0
            for v in adj[u]:
                if v != p:
                    # Initialize max_val_for_v with max_outside_u_val
                    max_val_for_v = max_outside_u_val

                    # Consider the component formed by cutting (u,p) (i.e., total_sum - subtree_sum[u])
                    # This component is outside v's subtree.
                    if n > 1: # This component is not the whole tree
                        max_val_for_v = max(max_val_for_v, total_sum - subtree_sum[u])

                    # Consider max_subtree_val from siblings of v
                    if child_idx > 0:
                        max_val_for_v = max(max_val_for_v, prefix_max_subtree[child_idx-1])
                    if child_idx < len(children_max_subtree_vals) - 1:
                        max_val_for_v = max(max_val_for_v, suffix_max_subtree[child_idx+1])

                    # Recursively call dfs2 for child v
                    dfs2(v, u, max_val_for_v)
                    child_idx += 1

        # Initial call for dfs2. For the root (node 0), there's nothing "outside" it initially.
        dfs2(0, -1, 0)

        return self.global_max_score