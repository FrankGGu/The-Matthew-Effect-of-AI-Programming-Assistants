class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def constructFromPrePost(self, preorder: list[int], postorder: list[int]) -> TreeNode:
        if not preorder:
            return None

        root = TreeNode(preorder[0])

        if len(preorder) == 1:
            return root

        left_root_val = preorder[1]
        left_len = postorder.index(left_root_val) + 1

        root.left = self.constructFromPrePost(preorder[1:left_len+1], postorder[:left_len])
        root.right = self.constructFromPrePost(preorder[left_len+1:], postorder[left_len:-1])

        return root