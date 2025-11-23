class Solution:
    def findTarget(self, root: Optional[TreeNode], k: int) -> bool:
        elements = set()
        stack = []
        current = root
        while stack or current:
            while current:
                stack.append(current)
                current = current.left
            current = stack.pop()
            if k - current.val in elements:
                return True
            elements.add(current.val)
            current = current.right
        return False