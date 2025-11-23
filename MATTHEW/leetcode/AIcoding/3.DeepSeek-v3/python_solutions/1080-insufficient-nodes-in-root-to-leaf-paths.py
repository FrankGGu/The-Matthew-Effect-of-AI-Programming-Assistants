class Solution:
    def sufficientSubset(self, root: TreeNode, limit: int) -> TreeNode:
        def dfs(node, current_sum):
            if not node:
                return None, current_sum
            current_sum += node.val
            if not node.left and not node.right:
                if current_sum < limit:
                    return None, current_sum
                else:
                    return node, current_sum
            left_node, left_sum = dfs(node.left, current_sum)
            right_node, right_sum = dfs(node.right, current_sum)
            if left_node is None and right_node is None:
                return None, max(left_sum, right_sum)
            node.left = left_node
            node.right = right_node
            return node, max(left_sum if left_node else -float('inf'), right_sum if right_node else -float('inf'))

        new_root, _ = dfs(root, 0)
        return new_root