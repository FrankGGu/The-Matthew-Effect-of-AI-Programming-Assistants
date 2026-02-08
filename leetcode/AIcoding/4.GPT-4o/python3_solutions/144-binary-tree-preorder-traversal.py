class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def preorderTraversal(self, root: TreeNode) -> List[int]:
        result = []
        self._preorder_helper(root, result)
        return result

    def _preorder_helper(self, node, result):
        if node:
            result.append(node.val)
            self._preorder_helper(node.left, result)
            self._preorder_helper(node.right, result)