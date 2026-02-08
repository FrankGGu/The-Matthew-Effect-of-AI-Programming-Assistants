class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def delNodes(self, root: TreeNode, to_delete: List[int]) -> List[TreeNode]:
        to_delete_set = set(to_delete)
        forest = []

        def helper(node):
            if not node:
                return None
            node_deleted = node.val in to_delete_set
            node.left = helper(node.left)
            node.right = helper(node.right)
            if node_deleted:
                if node.left:
                    forest.append(node.left)
                if node.right:
                    forest.append(node.right)
                return None
            return node

        if helper(root) is not None:
            forest.append(root)

        return forest