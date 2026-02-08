class Solution:
    def tree2str(self, root: Optional[TreeNode]) -> str:
        if not root:
            return ""

        result = str(root.val)

        left_str = self.tree2str(root.left)
        right_str = self.tree2str(root.right)

        if not left_str and not right_str:
            return result
        elif not right_str:
            return result + "(" + left_str + ")"
        else: # right_str is not empty
            # If right child exists, left child must be represented, even if empty
            return result + "(" + left_str + ")" + "(" + right_str + ")"