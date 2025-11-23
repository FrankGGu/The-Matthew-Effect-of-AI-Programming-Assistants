from typing import List, Optional

class Solution:
    def buildTree(self, inorder: List[int], postorder: List[int]) -> Optional[TreeNode]:
        if not inorder or not postorder:
            return None

        inorder_map = {val: idx for idx, val in enumerate(inorder)}

        def build(inorder_start: int, inorder_end: int, postorder_start: int, postorder_end: int) -> Optional[TreeNode]:
            if inorder_start >= inorder_end or postorder_start >= postorder_end:
                return None

            root_val = postorder[postorder_end - 1]
            root = TreeNode(root_val)

            root_idx_in_inorder = inorder_map[root_val]

            num_left_nodes = root_idx_in_inorder - inorder_start

            root.left = build(inorder_start, root_idx_in_inorder,
                              postorder_start, postorder_start + num_left_nodes)

            root.right = build(root_idx_in_inorder + 1, inorder_end,
                               postorder_start + num_left_nodes, postorder_end - 1)
            return root

        return build(0, len(inorder), 0, len(postorder))