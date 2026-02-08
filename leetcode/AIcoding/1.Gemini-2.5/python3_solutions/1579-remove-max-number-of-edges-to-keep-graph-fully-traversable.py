class DSU:
    def __init__(self, n):
        self.parent = list(range(n + 1))
        self.num_components = n

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            self.parent[root_i] = root_j
            self.num_components -= 1
            return True
        return False

class Solution:
    def maxNumEdgesToRemove(self, n: int, edges: list[list[int]]) -> int:

        dsu_alice = DSU(n)
        dsu_bob = DSU(n)

        edges_kept = 0

        # Sort edges by type in descending order: Type 3 first, then Type 2, then Type 1.
        # This prioritizes Type 3 edges which can benefit both Alice and Bob.
        edges.sort(key=lambda x: x[0], reverse=True) 

        for edge_type, u, v in edges:
            if edge_type == 3:
                # Try to union for both Alice and Bob.
                # An edge is kept if it connects components for at least one of them.
                # If it connects for Alice OR Bob, it's a useful Type 3 edge.
                union_alice_success = dsu_alice.union(u, v)
                union_bob_success = dsu_bob.union(u, v)

                if union_alice_success or union_bob_success:
                    edges_kept += 1
            elif edge_type == 1: # Alice only edge
                if dsu_alice.union(u, v):
                    edges_kept += 1
            elif edge_type == 2: # Bob only edge
                if dsu_bob.union(u, v):
                    edges_kept += 1

        # After processing all edges, check if both graphs are fully connected.
        # A graph with N nodes is fully connected if it has 1 component.
        if dsu_alice.num_components > 1 or dsu_bob.num_components > 1:
            return -1

        # The number of edges to remove is the total number of edges minus the edges we kept.
        return len(edges) - edges_kept