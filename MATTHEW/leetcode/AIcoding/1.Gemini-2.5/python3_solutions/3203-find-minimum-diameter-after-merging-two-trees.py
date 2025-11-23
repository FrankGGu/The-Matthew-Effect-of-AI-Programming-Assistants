from collections import deque

class Solution:
    def _get_tree_properties(self, n: int, edges: list[list[int]]):
        if n == 0:
            return -1, [] # Diameter, eccentricities
        if n == 1:
            return 0, [0]

        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        # BFS function: returns distances from start_node and the farthest node
        def bfs(start_node):
            distances = [-1] * n
            q = deque([(start_node, 0)])
            distances[start_node] = 0

            farthest_node = start_node
            max_dist = 0

            while q:
                curr_node, dist = q.popleft()
                if dist > max_dist:
                    max_dist = dist
                    farthest_node = curr_node

                for neighbor in adj[curr_node]:
                    if distances[neighbor] == -1:
                        distances[neighbor] = dist + 1
                        q.append((neighbor, dist + 1))
            return distances, farthest_node

        # Step 1: Find one endpoint (u) of a diameter
        # Start BFS from an arbitrary node (e.g., node 0) to find a farthest node.
        _, u = bfs(0)

        # Step 2: Find the other endpoint (v) of the diameter and distances from u
        # BFS from u to find the farthest node (v) and all distances from u.
        dist_u, v = bfs(u)

        diameter = dist_u[v]

        # Step 3: Find distances from v
        # BFS from v to get all distances from v.
        dist_v, _ = bfs(v)

        # Step 4: Calculate eccentricities for all nodes
        # The eccentricity of a node x is max(dist(x, u), dist(x, v))
        eccentricities = [0] * n
        for i in range(n):
            eccentricities[i] = max(dist_u[i], dist_v[i])

        return diameter, eccentricities

    def findMinimumDiameterAfterMergingTwoTrees(self, n1: int, edges1: list[list[int]], n2: int, edges2: list[list[int]]) -> int:

        diam1, ecc1 = self._get_tree_properties(n1, edges1)
        diam2, ecc2 = self._get_tree_properties(n2, edges2)

        candidates = []

        # Case 1: The new tree's diameter is entirely within tree1
        if n1 > 0:
            candidates.append(diam1)

        # Case 2: The new tree's diameter is entirely within tree2
        if n2 > 0:
            candidates.append(diam2)

        # Case 3: The new tree's diameter crosses the new edge
        # This diameter will be (radius of tree1) + 1 (for the new edge) + (radius of tree2)
        if n1 > 0 and n2 > 0:
            min_ecc1 = min(ecc1)
            min_ecc2 = min(ecc2)
            candidates.append(min_ecc1 + 1 + min_ecc2)

        if not candidates: # Both trees are empty
            return -1

        return max(candidates)