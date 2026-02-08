from typing import List

class Solution:
    def removeStones(self, stones: List[List[int]]) -> int:
        parent = {}

        def find(x):
            if x not in parent:
                parent[x] = x
            if parent[x] == x:
                return x
            parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX != rootY:
                parent[rootX] = rootY

        # Offset for column indices to distinguish them from row indices.
        # Max row/col index is 10^4, so 10001 is a safe offset.
        OFFSET = 10001 

        # Keep track of all unique row/column indices involved
        # to correctly count components later.
        all_involved_nodes = set()

        for r, c in stones:
            # Union row 'r' with column 'c + OFFSET'
            union(r, c + OFFSET)
            all_involved_nodes.add(r)
            all_involved_nodes.add(c + OFFSET)

        # Count the number of connected components.
        # This is the number of unique roots among all involved nodes.
        num_components = 0
        if all_involved_nodes:
            unique_roots = set()
            for node in all_involved_nodes:
                unique_roots.add(find(node))
            num_components = len(unique_roots)

        # The maximum number of stones that can be removed is
        # (total number of stones) - (number of connected components).
        return len(stones) - num_components