from typing import List

class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
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

def calculate_mst_weight(n, all_edges, exclude_original_idx=-1, include_original_idx=-1):
    dsu = DSU(n)
    mst_weight = 0

    # If an edge must be included, process it first
    if include_original_idx != -1:
        for u, v, w, original_idx in all_edges:
            if original_idx == include_original_idx:
                dsu.union(u, v)
                mst_weight += w
                break

    # Sort all edges by weight for Kruskal's algorithm
    sorted_edges = sorted(all_edges, key=lambda x: x[2])

    for u, v, w, original_idx in sorted_edges:
        # Skip the edge if it's meant to be excluded
        if original_idx == exclude_original_idx:
            continue

        # Skip the edge if it was already forced to be included
        if original_idx == include_original_idx:
            continue

        # If adding this edge connects two previously disconnected components
        if dsu.union(u, v):
            mst_weight += w

    # If all nodes are connected (i.e., num_components is 1), return MST weight
    # Otherwise, an MST could not be formed, return infinity
    if dsu.num_components == 1:
        return mst_weight
    else:
        return float('inf')

class Solution:
    def findCriticalAndPseudoCriticalEdges(self, n: int, edges: List[List[int]]) -> List[List[int]]:
        # Augment edges with their original indices
        indexed_edges = []
        for i, (u, v, w) in enumerate(edges):
            indexed_edges.append([u, v, w, i])

        # Calculate the weight of the minimum spanning tree for the original graph
        min_mst_weight = calculate_mst_weight(n, indexed_edges)

        # If the graph is disconnected, no MST can be formed, so no critical/pseudo-critical edges
        if min_mst_weight == float('inf'):
            return [[], []]

        critical_edges_set = set()
        pseudo_critical_edges = []

        # Find critical edges
        # An edge is critical if removing it increases the MST weight or makes an MST impossible
        for i in range(len(indexed_edges)):
            current_edge_original_idx = indexed_edges[i][3]

            weight_without_i = calculate_mst_weight(n, indexed_edges, exclude_original_idx=current_edge_original_idx)
            if weight_without_i > min_mst_weight:
                critical_edges_set.add(current_edge_original_idx)

        # Find pseudo-critical edges
        # An edge is pseudo-critical if it's not critical, but it can be part of *some* MST
        for i in range(len(indexed_edges)):
            current_edge_original_idx = indexed_edges[i][3]

            # Skip if already identified as critical
            if current_edge_original_idx in critical_edges_set:
                continue

            # Try to build an MST by forcing the current edge to be included
            weight_with_i_forced = calculate_mst_weight(n, indexed_edges, include_original_idx=current_edge_original_idx)
            if weight_with_i_forced == min_mst_weight:
                pseudo_critical_edges.append(current_edge_original_idx)

        return [list(critical_edges_set), pseudo_critical_edges]