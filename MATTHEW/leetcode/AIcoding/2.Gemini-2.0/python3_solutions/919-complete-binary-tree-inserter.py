from collections import deque

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class CBTInserter:

    def __init__(self, root: TreeNode):
        self.root = root
        self.queue = deque()
        queue = deque([root])
        while queue:
            node = queue.popleft()
            if not node.left or not node.right:
                self.queue.append(node)
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)

    def insert(self, val: int) -> int:
        node = self.queue[0]
        new_node = TreeNode(val)
        if not node.left:
            node.left = new_node
        else:
            node.right = new_node
            self.queue.popleft()
        self.queue.append(new_node)
        return node.val

    def get_root(self) -> TreeNode:
        return self.root