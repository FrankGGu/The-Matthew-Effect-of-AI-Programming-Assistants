import collections
from typing import Optional

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class CBTInserter:

    def __init__(self, root: Optional[TreeNode]):
        self.root = root
        self.parent_candidates = collections.deque()

        q = collections.deque([root])
        while q:
            node = q.popleft()

            if node.left is None or node.right is None:
                self.parent_candidates.append(node)

            if node.left:
                q.append(node.left)
            if node.right:
                q.append(node.right)

    def insert(self, val: int) -> int:
        new_node = TreeNode(val)

        parent = self.parent_candidates[0] 

        if parent.left is None:
            parent.left = new_node
        else:
            parent.right = new_node

        self.parent_candidates.append(new_node) 

        if parent.left and parent.right: 
            self.parent_candidates.popleft() 

        return parent.val

    def get_root(self) -> Optional[TreeNode]:
        return self.root