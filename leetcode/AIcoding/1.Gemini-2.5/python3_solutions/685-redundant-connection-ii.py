from typing import List

class DSU:
    def __init__(self, n):
        self.parent = list(range(n + 1))
        self.rank = [0] * (n + 1)

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
    def findRedundantDirectedConnection(self, edges: List[List[int]]) -> List[int]:
        n = len(edges)

        in_degree = [0] * (n + 1)
        parent_map = [0] * (n + 1)

        cand1 = None
        cand2 = None

        for u, v in edges:
            in_degree[v] += 1
            if in_degree[v] == 2:
                cand1 = [parent_map[v], v]
                cand2 = [u, v]
                # Break here because we only care about the first node that gets two parents
                # and the two edges involved. If there are multiple such nodes, the problem
                # implies there's a single redundant edge that causes this.
                break 
            parent_map[v] = u

        def check_for_cycle(exclude_edge):
            dsu = DSU(n)
            for u, v in edges:
                if u == exclude_edge[0] and v == exclude_edge[1]:
                    continue
                if not dsu.union(u, v):
                    return [u, v]
            return None

        if cand1 and cand2:
            # Case: A node has two parents.
            # Try removing cand2 (the one that appeared later in the input).
            # If removing cand2 results in a valid tree (no cycle), then cand2 is the answer.
            if check_for_cycle(cand2) is None:
                return cand2
            else:
                # If removing cand2 still leaves a cycle, then cand1 must be the answer.
                # This means cand1 itself was part of a cycle.
                return cand1
        else:
            # Case: No node has two parents, only a cycle.
            # Find the edge that forms the cycle.
            # We pass a dummy edge to exclude nothing, effectively processing all edges.
            return check_for_cycle([-1, -1])