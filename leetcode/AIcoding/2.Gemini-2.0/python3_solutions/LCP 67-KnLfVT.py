class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def decorateTree(self, root: TreeNode) -> TreeNode:
        def get_inorder(node):
            if not node:
                return []
            return get_inorder(node.left) + [node] + get_inorder(node.right)

        inorder = get_inorder(root)
        values = [node.val for node in inorder if node.val % 2 != 0]

        if not values:
            return root

        idx = 0
        for node in inorder:
            if node.val % 2 == 0:
                node.val = values[idx % len(values)]
                idx += 1
        return root