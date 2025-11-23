class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def bstFromPreorder(self, preorder: list[int]) -> TreeNode:
        def helper(preorder, lower, upper):
            if not preorder or preorder[0] < lower or preorder[0] > upper:
                return None

            val = preorder.pop(0)
            root = TreeNode(val)
            root.left = helper(preorder, lower, val)
            root.right = helper(preorder, val, upper)
            return root

        return helper(preorder, float('-inf'), float('inf'))