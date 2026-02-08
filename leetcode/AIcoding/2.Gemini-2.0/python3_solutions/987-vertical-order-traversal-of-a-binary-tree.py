from collections import defaultdict, deque

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def verticalTraversal(self, root: TreeNode) -> list[list[int]]:
        if not root:
            return []

        column_map = defaultdict(list)
        queue = deque([(root, 0, 0)])  # (node, column, row)

        while queue:
            node, column, row = queue.popleft()
            column_map[column].append((row, node.val))

            if node.left:
                queue.append((node.left, column - 1, row + 1))
            if node.right:
                queue.append((node.right, column + 1, row + 1))

        sorted_columns = sorted(column_map.keys())
        result = []

        for column in sorted_columns:
            column_values = sorted(column_map[column])
            result.append([val for row, val in column_values])

        return result