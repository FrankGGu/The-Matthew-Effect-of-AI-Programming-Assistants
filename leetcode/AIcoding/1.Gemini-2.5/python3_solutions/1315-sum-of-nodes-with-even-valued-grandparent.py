class Solution:
    def sumEvenGrandparent(self, root: TreeNode) -> int:
        def dfs(node, parent_val, grandparent_val):
            if not node:
                return 0

            current_node_sum = 0
            if grandparent_val % 2 == 0:
                current_node_sum += node.val

            left_sum = dfs(node.left, node.val, parent_val)
            right_sum = dfs(node.right, node.val, parent_val)

            return current_node_sum + left_sum + right_sum

        return dfs(root, -1, -1)