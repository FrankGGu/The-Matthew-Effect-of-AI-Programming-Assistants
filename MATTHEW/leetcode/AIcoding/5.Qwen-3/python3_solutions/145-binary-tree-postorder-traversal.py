class Solution:
    def postorderTraversal(self, root: TreeNode) -> List[int]:
        result = []
        self.postorder(root, result)
        return result

    def postorder(self, node, result):
        if node is None:
            return
        self.postorder(node.left, result)
        self.postorder(node.right, result)
        result.append(node.val)