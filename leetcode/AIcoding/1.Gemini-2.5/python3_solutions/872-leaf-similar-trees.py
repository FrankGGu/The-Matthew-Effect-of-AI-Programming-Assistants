class Solution:
    def leafSimilar(self, root1: Optional[TreeNode], root2: Optional[TreeNode]) -> bool:
        def _get_leaf_sequence(node: Optional[TreeNode]) -> list[int]:
            if not node:
                return []
            if not node.left and not node.right:
                return [node.val]

            left_leaves = _get_leaf_sequence(node.left)
            right_leaves = _get_leaf_sequence(node.right)

            return left_leaves + right_leaves

        leaves1 = _get_leaf_sequence(root1)
        leaves2 = _get_leaf_sequence(root2)

        return leaves1 == leaves2