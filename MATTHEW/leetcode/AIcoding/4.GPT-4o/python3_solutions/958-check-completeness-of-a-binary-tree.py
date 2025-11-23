class Solution:
    def isCompleteBinaryTree(self, root: Optional[TreeNode]) -> bool:
        if not root:
            return True

        queue = collections.deque([root])
        end = False

        while queue:
            node = queue.popleft()
            if not node:
                end = True
            else:
                if end:
                    return False
                queue.append(node.left)
                queue.append(node.right)

        return True