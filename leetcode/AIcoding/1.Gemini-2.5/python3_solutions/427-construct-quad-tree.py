"""
class Node:
    def __init__(self, val, isLeaf, topLeft, topRight, bottomLeft, bottomRight):
        self.val = val
        self.isLeaf = isLeaf
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
"""

class Solution:
    def construct(self, grid: list[list[int]]) -> 'Node':
        n = len(grid)

        def _construct_recursive(r_start, c_start, length):
            # Check if all values in the current region are the same
            first_val = grid[r_start][c_start]
            all_same = True
            for i in range(r_start, r_start + length):
                for j in range(c_start, c_start + length):
                    if grid[i][j] != first_val:
                        all_same = False
                        break
                if not all_same:
                    break

            if all_same:
                # Create a leaf node
                return Node(val=bool(first_val), isLeaf=True, topLeft=None, topRight=None, bottomLeft=None, bottomRight=None)
            else:
                # Create a non-leaf node
                # For non-leaf nodes, the 'val' attribute can be anything. We'll use True.
                node = Node(val=True, isLeaf=False, topLeft=None, topRight=None, bottomLeft=None, bottomRight=None)

                half_length = length // 2
                node.topLeft = _construct_recursive(r_start, c_start, half_length)
                node.topRight = _construct_recursive(r_start, c_start + half_length, half_length)
                node.bottomLeft = _construct_recursive(r_start + half_length, c_start, half_length)
                node.bottomRight = _construct_recursive(r_start + half_length, c_start + half_length, half_length)

                return node

        return _construct_recursive(0, 0, n)