class Solution:
    def buildTree(self, inorder: list[int], postorder: list[int]) -> TreeNode:
        inorder_val_to_idx = {val: idx for idx, val in enumerate(inorder)}

        def build(in_start: int, in_end: int, post_start: int, post_end: int) -> TreeNode:
            if in_start > in_end or post_start > post_end:
                return None

            root_val = postorder[post_end]
            root = TreeNode(root_val)

            root_idx_in_inorder = inorder_val_to_idx[root_val]

            left_subtree_size = root_idx_in_inorder - in_start

            root.left = build(in_start, root_idx_in_inorder - 1,
                              post_start, post_start + left_subtree_size - 1)

            root.right = build(root_idx_in_inorder + 1, in_end,
                               post_start + left_subtree_size, post_end - 1)

            return root

        return build(0, len(inorder) - 1, 0, len(postorder) - 1)