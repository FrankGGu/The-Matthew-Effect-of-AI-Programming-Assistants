import collections

class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            if self.rank[root_i] < self.rank[root_j]:
                self.parent[root_i] = root_j
            elif self.rank[root_i] > self.rank[root_j]:
                self.parent[root_j] = root_i
            else:
                self.parent[root_j] = root_i
                self.rank[root_i] += 1
            return True
        return False

class Solution:
    def assignToGroups(self, n: int, k: int, constraints: list[list[int]]) -> int:
        MOD = 10**9 + 7

        uf = UnionFind(n)

        # Step 1: Process type 0 constraints (elements must be in the same group)
        for idx1, idx2, type_val in constraints:
            if type_val == 0:
                uf.union(idx1, idx2)

        # Map original indices to their component roots
        # Get unique roots and map them to 0...num_distinct_roots-1
        distinct_roots_set = set()
        for i in range(n):
            distinct_roots_set.add(uf.find(i))

        root_to_id = {root: i for i, root in enumerate(distinct_roots_set)}
        num_distinct_roots = len(distinct_roots_set)

        # Step 2: Build conflict graph for type 1 constraints (elements must be in different groups)
        # Nodes in this graph are the distinct component roots (mapped to 0...num_distinct_roots-1)
        adj_conflict = collections.defaultdict(list)

        for idx1, idx2, type_val in constraints:
            if type_val == 1:
                root1 = uf.find(idx1)
                root2 = uf.find(idx2)

                # If two elements that must be in different groups are already forced into the same group
                if root1 == root2:
                    return 0 # Contradiction

                # Add edge in conflict graph between root IDs
                adj_conflict[root_to_id[root1]].append(root_to_id[root2])
                adj_conflict[root_to_id[root2]].append(root_to_id[root1])

        # Step 3: 2-coloring (bipartite check) of the conflict graph
        # Count isolated components and bipartite components (that require two groups)

        colors = [-1] * num_distinct_roots # -1: unvisited, 0: color 0, 1: color 1

        num_isolated_components = 0 # Components with no type 1 constraints
        num_bipartite_components = 0 # Components with at least one type 1 constraint

        for i in range(num_distinct_roots):
            if colors[i] == -1: # If component (in conflict graph) is unvisited
                q = collections.deque([(i, 0)]) # (node_id, color)
                colors[i] = 0

                has_edges = False # Flag to check if this connected component has any edges

                while q:
                    u_id, u_color = q.popleft()

                    for v_id in adj_conflict[u_id]:
                        has_edges = True # This component has at least one edge
                        if colors[v_id] == -1:
                            colors[v_id] = 1 - u_color
                            q.append((v_id, 1 - u_color))
                        elif colors[v_id] == u_color:
                            return 0 # Odd cycle detected, impossible to satisfy constraints

                if not has_edges:
                    num_isolated_components += 1
                else:
                    num_bipartite_components += 1

        # Minimum number of groups required:
        # Each isolated component needs 1 group.
        # Each bipartite component (with edges) needs 2 distinct groups.
        min_groups_required = num_isolated_components + 2 * num_bipartite_components
        if k < min_groups_required:
            return 0

        # Step 4: Dynamic Programming
        # dp[g] = number of ways to assign the processed components to g distinct groups
        # such that all type 1 constraints are satisfied.

        dp = [0] * (k + 1)
        dp[0] = 1 # 0 components assigned to 0 groups in 1 way

        # Add isolated components one by one
        for _ in range(num_isolated_components):
            new_dp = [0] * (k + 1)
            for g in range(k + 1):
                if dp[g] == 0:
                    continue

                # Assign to an existing group (g choices)
                new_dp[g] = (new_dp[g] + dp[g] * g) % MOD

                # Assign to a new group (k - g choices for which group it is)
                if g + 1 <= k:
                    new_dp[g+1] = (new_dp[g+1] + dp[g] * (k - g)) % MOD
            dp = new_dp

        # Add bipartite components one by one (each forces two distinct groups)
        for _ in range(num_bipartite_components):
            new_dp = [0] * (k + 1)
            for g in range(k + 1):
                if dp[g] == 0:
                    continue

                # Case 1: Both sets (S0, S1) go to existing groups (g * (g-1) ways)
                if g >= 2:
                    new_dp[g] = (new_dp[g] + dp[g] * g * (g-1)) % MOD

                # Case 2: One set (S0) to existing, other (S1) to a new group (g * (k-g) ways)
                if g + 1 <= k:
                    new_dp[g+1] = (new_dp[g+1] + dp[g] * g * (k-g)) % MOD

                # Case 3: One set (S0) to a new group, other (S1) to existing ((k-g) * g ways)
                if g + 1 <= k:
                    new_dp[g+1] = (new_dp[g+1] + dp[g] * (k-g) * g) % MOD

                # Case 4: Both sets (S0, S1) go to two different new groups ((k-g) * (k-g-1) ways)
                if g + 2 <= k:
                    new_dp[g+2] = (new_dp[g+2] + dp[g] * (k-g) * (k-g-1)) % MOD
            dp = new_dp

        return dp[k]