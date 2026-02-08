class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:
        if not preorder or not inorder:
            return None

        inorder_map = {val: idx for idx, val in enumerate(inorder)}

        def _build(preorder_start: int, preorder_end: int, inorder_start: int, inorder_end: int) -> Optional[TreeNode]:
            if preorder_start >= preorder_end or inorder_start >= inorder_end:
                return None

            root_val = preorder[preorder_start]
            root = TreeNode(root_val)

            inorder_root_idx = inorder_map[root_val]

            left_subtree_size = inorder_root_idx - inorder_start

            root.left = _build(
                preorder_start + 1,
                preorder_start + 1 + left_subtree_size,
                inorder_start,
                inorder_root_idx
            )

            root.right = _build(
                preorder_start + 1 + left_subtree_size,
                preorder_end,
                inorder_root_idx + 1,
                inorder_end
            )

            return root

        return _build(0, len(preorder), 0, len(inorder))