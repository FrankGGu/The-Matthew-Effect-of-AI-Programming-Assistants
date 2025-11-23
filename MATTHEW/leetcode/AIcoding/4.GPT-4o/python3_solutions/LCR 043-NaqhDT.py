class CBTInserter:

    def __init__(self, root: TreeNode):
        self.root = root
        self.queue = []
        self.queue.append(root)
        while self.queue:
            node = self.queue.pop(0)
            if node.left:
                self.queue.append(node.left)
            if node.right:
                self.queue.append(node.right)
            else:
                break
        self.queue.append(node)

    def insert(self, val: int) -> int:
        new_node = TreeNode(val)
        if not self.queue[0].left:
            self.queue[0].left = new_node
        else:
            self.queue[0].right = new_node
            self.queue.pop(0)
            if self.queue and not self.queue[0].left:
                self.queue.append(self.queue[0])
        return self.queue[0].val

    def get_root(self) -> TreeNode:
        return self.root