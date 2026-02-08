class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def increasingBST(self, root: TreeNode) -> TreeNode:
        nodes = []
        def inorder(node):
            if not node:
                return
            inorder(node.left)
            nodes.append(node)
            inorder(node.right)

        inorder(root)
        if not nodes:
            return None

        new_root = nodes[0]
        new_root.left = None
        curr = new_root

        for i in range(1, len(nodes)):
            nodes[i].left = None
            curr.right = nodes[i]
            curr = curr.right

        return new_root