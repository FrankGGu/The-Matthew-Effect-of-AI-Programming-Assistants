from collections import defaultdict

class Solution:
    def frogPosition(self, n: int, edges: list[list[int]], t: int, target: int) -> float:
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        def get_num_valid_neighbors(u, p):
            count = 0
            for v in adj[u]:
                if v != p:
                    count += 1
            return count

        def dfs(u, p, t_elapsed, prob):
            # If time has exceeded 't', this path is invalid.
            if t_elapsed > t:
                return 0.0

            # Determine if current node 'u' is a leaf in the traversal path
            # (i.e., it has no neighbors other than its parent 'p').
            num_children_to_jump_to = get_num_valid_neighbors(u, p)
            is_leaf_in_traversal = (num_children_to_jump_to == 0)

            # Case 1: Current node is the target node.
            if u == target:
                if t_elapsed == t:
                    # Reached target exactly at time 't'. This is a successful path.
                    return prob
                elif t_elapsed < t:
                    # Reached target too early.
                    # The frog stays only if it's a leaf node (no other places to jump).
                    if is_leaf_in_traversal:
                        return prob
                    else:
                        # The frog has other places to jump, so it will move away from the target.
                        return 0.0
                # If t_elapsed > t, it's handled by the first check.

            # Case 2: Current node is not the target node, and time is up.
            # The frog cannot reach the target from here within the given time.
            if t_elapsed == t and u != target:
                return 0.0

            # Case 3: Current node is not the target, and there's time remaining (t_elapsed < t).
            # The frog must jump if possible.
            if num_children_to_jump_to == 0:
                # The frog is stuck at 'u' (which is not the target) before time 't' is up.
                # It cannot reach the target from here.
                return 0.0

            # Explore neighbors if the frog can jump.
            current_path_prob = 0.0
            for v in adj[u]:
                if v != p:  # Only jump to unvisited children (not the parent)
                    current_path_prob += dfs(v, u, t_elapsed + 1, prob / num_children_to_jump_to)

            return current_path_prob

        # Start DFS from node 1 (the frog's initial position), with a dummy parent 0,
        # initial time 0, and initial probability 1.0.
        return dfs(1, 0, 0, 1.0)