from collections import deque

class CBTInserter:

    def __init__(self, root: TreeNode):
        self.root = root
        self.queue = deque()
        self.nodes = []
        self._bfs()

    def _bfs(self):
        queue = deque([self.root])
        while queue:
            node = queue.popleft()
            self.nodes.append(node)
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)

    def insert(self, val: int) -> int:
        new_node = TreeNode(val)
        parent = self.nodes[(len(self.nodes) - 1) // 2]
        if not parent.left:
            parent.left = new_node
        else:
            parent.right = new_node
        self.nodes.append(new_node)
        return parent.val

    def get_root(self) -> TreeNode:
        return self.root