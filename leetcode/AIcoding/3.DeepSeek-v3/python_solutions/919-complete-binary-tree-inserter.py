class CBTInserter:

    def __init__(self, root: TreeNode):
        self.root = root
        self.queue = []
        q = [root]
        while q:
            node = q.pop(0)
            if not node.left or not node.right:
                self.queue.append(node)
            if node.left:
                q.append(node.left)
            if node.right:
                q.append(node.right)

    def insert(self, val: int) -> int:
        new_node = TreeNode(val)
        parent = self.queue[0]
        if not parent.left:
            parent.left = new_node
        else:
            parent.right = new_node
            self.queue.pop(0)
        self.queue.append(new_node)
        return parent.val

    def get_root(self) -> TreeNode:
        return self.root