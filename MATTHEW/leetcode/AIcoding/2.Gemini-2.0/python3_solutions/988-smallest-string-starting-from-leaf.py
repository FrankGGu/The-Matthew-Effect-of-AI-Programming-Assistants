class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def smallestFromLeaf(self, root: TreeNode) -> str:
        def dfs(node, path):
            if not node:
                return ""

            new_path = chr(ord('a') + node.val) + path

            if not node.left and not node.right:
                return new_path

            left_str = dfs(node.left, new_path) if node.left else None
            right_str = dfs(node.right, new_path) if node.right else None

            if left_str is None:
                return right_str
            elif right_str is None:
                return left_str
            else:
                return min(left_str, right_str)

        return dfs(root, "")