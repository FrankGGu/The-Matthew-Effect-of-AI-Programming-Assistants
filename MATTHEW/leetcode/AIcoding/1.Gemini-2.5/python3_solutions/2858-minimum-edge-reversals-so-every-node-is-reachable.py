import collections

class Solution:
    def minEdgeReversals(self, n: int, edges: list[list[int]]) -> list[int]:
        adj = collections.defaultdict(list)
        for u, v in edges:
            # For an original edge u -> v:
            # Add (v, 0) to adj[u]: cost to traverse u -> v is 0
            adj[u].append((v, 0))
            # Add (u, 1) to adj[v]: cost to traverse v -> u is 1 (requires reversing u -> v)
            adj[v].append((u, 1))

        dp_down = [0] * n

        # dfs_down calculates the number of reversals needed to make all nodes
        # in the subtree rooted at 'u' reachable from 'u', assuming 'u' is
        # the parent of its children in the DFS tree.
        def dfs_down(u, p):
            current_reversals = 0
            for v, cost_u_to_v in adj[u]:
                if v == p:
                    continue
                current_reversals += dfs_down(v, u)
                current_reversals += cost_u_to_v
            dp_down[u] = current_reversals
            return current_reversals

        # Perform the first DFS pass starting from node 0 to populate dp_down.
        dfs_down(0, -1) 

        dp_up = [0] * n
        ans = [0] * n

        # dfs_up calculates the number of reversals needed to make 'u' and
        # all nodes outside its subtree reachable from 'u'.
        # It also calculates the total reversals for each node when it is considered as the root.
        def dfs_up(u, p):
            # The total reversals if 'u' is the root is the sum of reversals
            # within its subtree (dp_down[u]) and reversals needed for the
            # rest of the graph (dp_up[u]).
            ans[u] = dp_down[u] + dp_up[u]

            for v, cost_u_to_v in adj[u]:
                if v == p:
                    continue

                # cost_v_to_u is the cost to traverse the edge from v to u.
                # If original edge was u -> v (cost_u_to_v = 0), then v -> u requires reversal (cost_v_to_u = 1).
                # If original edge was v -> u (cost_u_to_v = 1), then v -> u is natural (cost_v_to_u = 0).
                cost_v_to_u = 1 - cost_u_to_v

                # dp_up[v] is calculated using dp_up[u] and dp_down values.
                # It's the sum of:
                # 1. cost_v_to_u: cost to make 'u' reachable from 'v' via the direct edge.
                # 2. dp_up[u]: cost to make 'u' and its "ancestor" part of the graph reachable from 'u'.
                # 3. (dp_down[u] - (dp_down[v] + cost_u_to_v)): cost to make 'u's other children's subtrees
                #    reachable from 'u'. This effectively removes 'v's subtree contribution from dp_down[u].
                dp_up[v] = cost_v_to_u + dp_up[u] + (dp_down[u] - (dp_down[v] + cost_u_to_v))

                dfs_up(v, u)

        # Perform the second DFS pass to propagate 'up' costs and calculate final answers.
        dfs_up(0, -1)

        return ans