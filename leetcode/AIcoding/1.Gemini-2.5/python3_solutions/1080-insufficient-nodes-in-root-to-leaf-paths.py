class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def sufficientSubset(self, root: TreeNode, limit: int) -> TreeNode:

        def dfs(node: TreeNode, current_path_sum_so_far: int) -> TreeNode:
            if not node:
                return None

            new_path_sum = current_path_sum_so_far + node.val

            # If it's a leaf node
            if not node.left and not node.right:
                if new_path_sum < limit:
                    return None
                else:
                    return node

            # If it's not a leaf node, recursively process children
            node.left = dfs(node.left, new_path_sum)
            node.right = dfs(node.right, new_path_sum)

            # After processing children, check if this node has become a leaf
            # (i.e., both children were removed or were initially None)
            if not node.left and not node.right:
                # If it became a leaf and its path sum is insufficient, remove it
                if new_path_sum < limit:
                    return None
                else:
                    return node

            # If it still has at least one child, keep it
            return node

        return dfs(root, 0)