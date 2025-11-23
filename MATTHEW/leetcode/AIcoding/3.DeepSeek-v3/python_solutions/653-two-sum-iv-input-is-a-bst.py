class Solution:
    def findTarget(self, root: Optional[TreeNode], k: int) -> bool:
        seen = set()
        stack = [root]
        while stack:
            node = stack.pop()
            if node:
                if (k - node.val) in seen:
                    return True
                seen.add(node.val)
                stack.append(node.right)
                stack.append(node.left)
        return False