class Solution:
    def searchBST(self, root: Optional[TreeNode], val: int) -> Optional[TreeNode]:
        current = root
        while current:
            if current.val == val:
                return current
            elif val < current.val:
                current = current.left
            else:
                current = current.right
        return None