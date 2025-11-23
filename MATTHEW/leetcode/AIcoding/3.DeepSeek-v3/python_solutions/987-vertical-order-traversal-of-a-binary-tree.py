class Solution:
    def verticalTraversal(self, root: Optional[TreeNode]) -> List[List[int]]:
        if not root:
            return []

        nodes = []
        def dfs(node, row, col):
            if not node:
                return
            nodes.append((col, row, node.val))
            dfs(node.left, row + 1, col - 1)
            dfs(node.right, row + 1, col + 1)

        dfs(root, 0, 0)
        nodes.sort()

        result = []
        current_col = None
        current_list = []
        for col, row, val in nodes:
            if col == current_col:
                current_list.append(val)
            else:
                if current_list:
                    result.append(current_list)
                current_col = col
                current_list = [val]
        if current_list:
            result.append(current_list)

        return result