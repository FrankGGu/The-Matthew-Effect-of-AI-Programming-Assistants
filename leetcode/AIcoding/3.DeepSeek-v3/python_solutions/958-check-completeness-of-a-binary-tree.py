class Solution:
    def isCompleteTree(self, root: Optional[TreeNode]) -> bool:
        if not root:
            return True

        queue = [root]
        has_null = False

        while queue:
            node = queue.pop(0)
            if not node:
                has_null = True
                continue
            if has_null:
                return False
            queue.append(node.left)
            queue.append(node.right)

        return True