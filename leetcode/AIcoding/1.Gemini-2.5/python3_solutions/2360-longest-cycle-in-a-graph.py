class Solution:
    def longestCycle(self, edges: list[int]) -> int:
        n = len(edges)
        visited = [False] * n
        max_cycle_length = -1

        for i in range(n):
            if not visited[i]:
                path_visited_step = {}  # Stores {node: step_count} for the current DFS path
                current_node = i
                current_step = 0

                while current_node != -1 and not visited[current_node]:
                    visited[current_node] = True
                    path_visited_step[current_node] = current_step

                    current_node = edges[current_node]
                    current_step += 1

                # After the loop, current_node is either -1 (path ended)
                # or it's a node that has been visited before.
                # If it's in path_visited_step, it means we found a cycle in the current path.
                if current_node != -1 and current_node in path_visited_step:
                    cycle_length = current_step - path_visited_step[current_node]
                    max_cycle_length = max(max_cycle_length, cycle_length)

        return max_cycle_length