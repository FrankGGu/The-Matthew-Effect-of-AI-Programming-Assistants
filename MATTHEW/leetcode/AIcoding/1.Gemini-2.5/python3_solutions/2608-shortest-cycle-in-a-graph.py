import collections

class Solution:
    def findShortestCycle(self, n: int, edges: list[list[int]]) -> int:
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        min_cycle_len = float('inf')

        for start_node in range(n):
            q = collections.deque([(start_node, 0)]) # (node, distance from start_node)

            # dist[node] stores the shortest distance from start_node to node in the current BFS tree
            # parent[node] stores the parent of node in the current BFS tree
            dist = {start_node: 0}
            parent = {start_node: -1} # Use -1 to indicate no parent (for the start_node)

            while q:
                u, d = q.popleft()

                for v in adj[u]:
                    if v == parent[u]:
                        # Skip the edge that goes back to the immediate parent in the BFS tree
                        continue

                    if v in dist:
                        # If v has been visited in this BFS and is not the immediate parent of u,
                        # a cycle is detected.
                        # The cycle path is start_node -> ... -> u -> v -> ... -> start_node.
                        # The length is (distance from start_node to u) + 1 (for edge u-v) + (distance from start_node to v).
                        cycle_len = d + dist[v] + 1
                        min_cycle_len = min(min_cycle_len, cycle_len)
                    else:
                        # If v is not visited, add it to the queue and update its distance and parent
                        dist[v] = d + 1
                        parent[v] = u
                        q.append((v, d + 1))

        return min_cycle_len if min_cycle_len != float('inf') else -1