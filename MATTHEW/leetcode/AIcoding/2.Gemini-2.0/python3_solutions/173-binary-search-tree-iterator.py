class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class BSTIterator:

    def __init__(self, root: TreeNode):
        self.stack = []
        self._inorder_left(root)

    def _inorder_left(self, root):
        while root:
            self.stack.append(root)
            root = root.left

    def next(self) -> int:
        node = self.stack.pop()
        self._inorder_left(node.right)
        return node.val

    def hasNext(self) -> bool:
        return len(self.stack) > 0