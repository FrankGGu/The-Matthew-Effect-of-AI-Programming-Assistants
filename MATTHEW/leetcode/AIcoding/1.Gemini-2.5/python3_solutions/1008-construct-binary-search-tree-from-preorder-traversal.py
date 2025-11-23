class Solution:
    def bstFromPreorder(self, preorder: List[int]) -> Optional[TreeNode]:
        self.idx = 0
        self.preorder = preorder

        def build(lower_bound, upper_bound):
            if self.idx == len(self.preorder) or not (lower_bound < self.preorder[self.idx] < upper_bound):
                return None

            root_val = self.preorder[self.idx]
            root = TreeNode(root_val)
            self.idx += 1

            root.left = build(lower_bound, root_val)
            root.right = build(root_val, upper_bound)

            return root

        return build(float('-inf'), float('inf'))