class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class BSTIterator:
    def __init__(self, root: TreeNode):
        self.stack = []
        self.current = root
        while self.current:
            self.stack.append(self.current)
            self.current = self.current.left

    def next(self) -> int:
        node = self.stack.pop()
        current = node.right
        while current:
            self.stack.append(current)
            current = current.left
        return node.val

    def hasNext(self) -> bool:
        return len(self.stack) > 0