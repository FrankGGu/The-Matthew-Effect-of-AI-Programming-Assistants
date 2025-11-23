class Solution:
    def constructFromPrePost(self, preorder: List[int], postorder: List[int]) -> Optional[TreeNode]:
        if not preorder:
            return None

        root_val = preorder[0]
        root = TreeNode(root_val)

        if len(preorder) == 1:
            return root

        # The root of the left subtree is always the second element in preorder
        left_root_val = preorder[1]

        # Find the index of left_root_val in the postorder traversal
        # This index tells us how many nodes are in the left subtree
        # All elements from index 0 up to this index (inclusive) belong to the left subtree in postorder
        idx_in_postorder = postorder.index(left_root_val)

        # The number of nodes in the left subtree (including left_root_val itself)
        left_subtree_size = idx_in_postorder + 1

        # Split preorder and postorder arrays for the left and right subtrees
        # Preorder structure: [root, left_subtree_preorder, right_subtree_preorder]
        # Postorder structure: [left_subtree_postorder, right_subtree_postorder, root]

        # Left subtree slices
        # Preorder for left: from 1st element (after main root) up to left_subtree_size elements
        left_preorder = preorder[1 : 1 + left_subtree_size]
        # Postorder for left: from 0th element up to left_subtree_size elements
        left_postorder = postorder[0 : left_subtree_size]

        # Right subtree slices
        # Preorder for right: remaining elements after main root and left subtree
        right_preorder = preorder[1 + left_subtree_size : ]
        # Postorder for right: remaining elements before main root, after left subtree
        right_postorder = postorder[left_subtree_size : -1] 

        # Recursively construct the left and right subtrees
        root.left = self.constructFromPrePost(left_preorder, left_postorder)
        root.right = self.constructFromPrePost(right_preorder, right_postorder)

        return root