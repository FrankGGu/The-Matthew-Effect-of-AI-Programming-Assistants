class Solution:
    def buildTree(self, inorder: List[int], postorder: List[int]) -> TreeNode:
        if not inorder or not postorder:
            return None

        root_val = postorder[-1]
        root = TreeNode(root_val)

        root_pos = inorder.index(root_val)

        root.left = self.buildTree(inorder[:root_pos], postorder[:root_pos])
        root.right = self.buildTree(inorder[root_pos+1:], postorder[root_pos:-1])

        return root