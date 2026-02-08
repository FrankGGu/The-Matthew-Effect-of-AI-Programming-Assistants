import bisect
from typing import List, Optional

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def closestNodes(self, root: Optional[TreeNode], queries: List[int]) -> List[List[int]]:
        sorted_nodes = []

        def inorder_traversal(node):
            if not node:
                return
            inorder_traversal(node.left)
            sorted_nodes.append(node.val)
            inorder_traversal(node.right)

        inorder_traversal(root)

        results = []
        for query_val in queries:
            min_val = -1
            max_val = -1

            # Find min_val (smallest node value >= query_val)
            # bisect_left returns an insertion point which comes before (to the left of) any existing entries of x in a.
            # If all elements are smaller than query_val, it returns len(sorted_nodes).
            idx_min = bisect.bisect_left(sorted_nodes, query_val)
            if idx_min < len(sorted_nodes):
                min_val = sorted_nodes[idx_min]

            # Find max_val (largest node value <= query_val)
            # bisect_right returns an insertion point which comes after (to the right of) any existing entries of x in a.
            # If all elements are larger than query_val, it returns 0.
            idx_max = bisect.bisect_right(sorted_nodes, query_val)
            if idx_max > 0:
                max_val = sorted_nodes[idx_max - 1]

            results.append([min_val, max_val])

        return results