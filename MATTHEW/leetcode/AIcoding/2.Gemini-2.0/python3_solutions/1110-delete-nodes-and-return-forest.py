class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def delNodes(self, root: TreeNode, to_delete: list[int]) -> list[TreeNode]:
        res = []
        to_delete = set(to_delete)

        def helper(node, is_root):
            if not node:
                return None

            deleted = node.val in to_delete

            node.left = helper(node.left, deleted)
            node.right = helper(node.right, deleted)

            if is_root and not deleted:
                res.append(node)

            if deleted:
                return None
            else:
                return node

        helper(root, True)
        return res