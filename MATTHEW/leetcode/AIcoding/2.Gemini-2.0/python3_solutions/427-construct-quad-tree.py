class Node:
    def __init__(self, val, isLeaf, topLeft, topRight, bottomLeft, bottomRight):
        self.val = val
        self.isLeaf = isLeaf
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight

class Solution:
    def construct(self, grid: list[list[int]]) -> 'Node':
        n = len(grid)
        if n == 0:
            return None

        def build_tree(grid, row_start, row_end, col_start, col_end):
            if row_start > row_end or col_start > col_end:
                return None

            first_val = grid[row_start][col_start]
            is_leaf = True
            for i in range(row_start, row_end + 1):
                for j in range(col_start, col_end + 1):
                    if grid[i][j] != first_val:
                        is_leaf = False
                        break
                if not is_leaf:
                    break

            if is_leaf:
                return Node(first_val == 1, True, None, None, None, None)
            else:
                mid_row = (row_start + row_end) // 2
                mid_col = (col_start + col_end) // 2

                top_left = build_tree(grid, row_start, mid_row, col_start, mid_col)
                top_right = build_tree(grid, row_start, mid_row, mid_col + 1, col_end)
                bottom_left = build_tree(grid, mid_row + 1, row_end, col_start, mid_col)
                bottom_right = build_tree(grid, mid_row + 1, row_end, mid_col + 1, col_end)

                return Node(False, False, top_left, top_right, bottom_left, bottom_right)

        return build_tree(grid, 0, n - 1, 0, n - 1)