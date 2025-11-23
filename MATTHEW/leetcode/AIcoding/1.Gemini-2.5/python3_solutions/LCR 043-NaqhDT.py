import collections

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class CBTInserter:

    def __init__(self, root: TreeNode):
        self.root = root
        self.nodes_list = [] # Stores all nodes in BFS order

        q = collections.deque()
        if root:
            q.append(root)

        while q:
            node = q.popleft()
            self.nodes_list.append(node)

            if node.left:
                q.append(node.left)
            if node.right:
                q.append(node.right)

        # Find the first node that is not full (has less than 2 children)
        # This will be the parent for the next insertion
        self.next_parent_idx = 0
        while self.next_parent_idx < len(self.nodes_list):
            node = self.nodes_list[self.next_parent_idx]
            if not node.left or not node.right:
                break
            self.next_parent_idx += 1

    def insert(self, val: int) -> int:
        new_node = TreeNode(val)
        self.nodes_list.append(new_node)

        parent = self.nodes_list[self.next_parent_idx]

        if not parent.left:
            parent.left = new_node
        else:
            parent.right = new_node
            # If parent now has both children, it's full. Move to the next parent.
            self.next_parent_idx += 1

        return parent.val

    def get_root(self) -> TreeNode:
        return self.root