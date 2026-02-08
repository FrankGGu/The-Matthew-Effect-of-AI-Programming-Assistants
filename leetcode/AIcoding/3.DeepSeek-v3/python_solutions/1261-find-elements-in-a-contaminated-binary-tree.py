class FindElements:

    def __init__(self, root: TreeNode):
        self.elements = set()
        root.val = 0
        self.elements.add(0)
        queue = [root]
        while queue:
            node = queue.pop(0)
            if node.left:
                node.left.val = 2 * node.val + 1
                self.elements.add(node.left.val)
                queue.append(node.left)
            if node.right:
                node.right.val = 2 * node.val + 2
                self.elements.add(node.right.val)
                queue.append(node.right)

    def find(self, target: int) -> bool:
        return target in self.elements