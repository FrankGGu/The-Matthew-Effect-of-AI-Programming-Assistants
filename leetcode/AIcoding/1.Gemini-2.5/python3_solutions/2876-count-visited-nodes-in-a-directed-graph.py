from collections import deque

class Solution:
    def countVisitedNodes(self, edges: list[int]) -> list[int]:
        n = len(edges)
        ans = [0] * n

        # visited_state: 0 = unvisited, 1 = visiting (on current DFS path), 2 = visited (ans computed)
        visited_state = [0] * n

        # Reverse adjacency list for predecessors
        rev_adj = [[] for _ in range(n)]
        for i in range(n):
            rev_adj[edges[i]].append(i)

        # path_stack: Stores nodes in the current DFS path to detect cycles
        path_stack = []

        def dfs(u: int) -> int:
            # If already computed, return the stored answer
            if visited_state[u] == 2:
                return ans[u]

            # If currently visiting, a cycle is detected in the reverse graph
            if visited_state[u] == 1:
                # Reconstruct the cycle nodes from path_stack
                cycle_start_idx = path_stack.index(u)
                cycle_nodes = path_stack[cycle_start_idx:]

                # Calculate the initial count for the cycle (its own length)
                total_count = len(cycle_nodes)

                # Collect predecessors to cycle nodes that are not part of the cycle
                external_predecessors = set()
                for node_in_cycle in cycle_nodes:
                    for pred in rev_adj[node_in_cycle]:
                        # Check if predecessor is outside the current cycle
                        if pred not in cycle_nodes:
                            external_predecessors.add(pred)

                # Recursively call dfs for external predecessors and add their counts
                for pred in external_predecessors:
                    total_count += dfs(pred)

                # Assign the total_count to all nodes in the cycle
                for node_in_cycle in cycle_nodes:
                    ans[node_in_cycle] = total_count
                    visited_state[node_in_cycle] = 2 # Mark as fully processed

                return total_count

            # Mark node as visiting
            visited_state[u] = 1
            path_stack.append(u)

            # Initialize count for u itself
            count = 1

            # Recursively call dfs for all predecessors in the reverse graph
            for prev_node in rev_adj[u]:
                count += dfs(prev_node)

            # Store the computed answer and mark as fully processed
            ans[u] = count
            visited_state[u] = 2
            path_stack.pop()

            return count

        # Iterate through all nodes to ensure all components are processed
        for i in range(n):
            if visited_state[i] == 0: # If unvisited, start DFS
                dfs(i)

        return ans