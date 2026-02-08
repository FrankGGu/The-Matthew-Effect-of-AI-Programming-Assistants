class CBTInserter:

    def __init__(self, root: Optional[TreeNode]):
        self.root = root
        self.queue = [root]
        while self.queue:
            node = self.queue[0]
            if not node.left or not node.right:
                break
            self.queue.append(node.left)
            self.queue.append(node.right)
            self.queue.pop(0)
        self.last = node

    def insert(self, val: int) -> int:
        new_node = TreeNode(val)
        if not self.last.left:
            self.last.left = new_node
        else:
            self.last.right = new_node
            self.queue.append(self.last.left)
            self.queue.append(self.last.right)
            self.queue.pop(0)
            self.last = self.queue[0]
        return self.last.val

    def get_root(self) -> Optional[TreeNode]:
        return self.root