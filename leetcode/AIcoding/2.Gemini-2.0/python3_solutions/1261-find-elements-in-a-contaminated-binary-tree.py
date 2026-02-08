class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class FindElements:

    def __init__(self, root: TreeNode):
        self.values = set()
        if root:
            root.val = 0
            self.values.add(0)
            self.recover(root)

    def recover(self, node: TreeNode):
        if node.left:
            node.left.val = 2 * node.val + 1
            self.values.add(node.left.val)
            self.recover(node.left)
        if node.right:
            node.right.val = 2 * node.val + 2
            self.values.add(node.right.val)
            self.recover(node.right)

    def find(self, target: int) -> bool:
        return target in self.values