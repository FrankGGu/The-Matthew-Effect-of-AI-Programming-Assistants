import collections

class Solution:
    def timeTakenToMarkAllNodes(self, n: int, edges: list[list[int]], marked_nodes: list[int], k: int) -> int:
        if n == 0:
            return 0

        if k == 0:
            if len(marked_nodes) == n:
                return 0
            elif len(marked_nodes) > 0:
                return 1
            # If len(marked_nodes) == 0 and n > 0, it means no nodes are initially marked.
            # With k=0, no nodes will ever be marked. This scenario implies impossibility
            # to mark all nodes, which usually means such input won't be provided
            # given the problem title "Time Taken to Mark All Nodes".
            # If it could happen, the return value would typically be -1 or raise an error.
            # Assuming valid input where all nodes can eventually be marked.

        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        time_to_mark = [-1] * n  # -1 means not yet marked
        marked_neighbors_count = [0] * n
        q = collections.deque()
        num_marked_nodes = 0
        max_time = 0

        for node in marked_nodes:
            if time_to_mark[node] == -1:
                time_to_mark[node] = 0
                q.append((node, 0))
                num_marked_nodes += 1

        if num_marked_nodes == n:
            return 0

        for i in range(n):
            if time_to_mark[i] == 0:
                for neighbor in adj[i]:
                    if time_to_mark[neighbor] == -1:
                        marked_neighbors_count[neighbor] += 1
                        if marked_neighbors_count[neighbor] == k:
                            time_to_mark[neighbor] = 1
                            q.append((neighbor, 1))
                            num_marked_nodes += 1
                            max_time = max(max_time, 1)

        if num_marked_nodes == n:
            return max_time

        while q and num_marked_nodes < n:
            curr_node, curr_time = q.popleft()

            for neighbor in adj[curr_node]:
                if time_to_mark[neighbor] == -1:
                    marked_neighbors_count[neighbor] += 1
                    if marked_neighbors_count[neighbor] == k:
                        new_time = curr_time + 1
                        time_to_mark[neighbor] = new_time
                        q.append((neighbor, new_time))
                        num_marked_nodes += 1
                        max_time = max(max_time, new_time)

        return max_time