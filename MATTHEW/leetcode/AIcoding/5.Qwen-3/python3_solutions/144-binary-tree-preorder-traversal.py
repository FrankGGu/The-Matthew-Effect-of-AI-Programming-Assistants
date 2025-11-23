class Solution:
    def preorderTraversal(self, root: TreeNode) -> List[int]:
        result = []
        self.preorder(root, result)
        return result

    def preorder(self, node, result):
        if node is None:
            return
        result.append(node.val)
        self.preorder(node.left, result)
        self.preorder(node.right, result)