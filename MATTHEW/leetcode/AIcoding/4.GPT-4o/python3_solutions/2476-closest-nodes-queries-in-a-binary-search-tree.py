class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class BST:
    def __init__(self):
        self.root = None

    def insert(self, val):
        if not self.root:
            self.root = TreeNode(val)
        else:
            self._insert(self.root, val)

    def _insert(self, node, val):
        if val < node.val:
            if node.left:
                self._insert(node.left, val)
            else:
                node.left = TreeNode(val)
        else:
            if node.right:
                self._insert(node.right, val)
            else:
                node.right = TreeNode(val)

    def closest_nodes(self, query):
        res = []
        for q in query:
            lower, upper = self._find_closest(self.root, q)
            res.append([lower, upper])
        return res

    def _find_closest(self, node, target):
        lower = upper = None

        while node:
            if node.val < target:
                lower = node.val
                node = node.right
            elif node.val > target:
                upper = node.val
                node = node.left
            else:
                return [node.val, node.val]

        return [lower, upper]

class Solution:
    def closestNodes(self, root: TreeNode, queries: List[int]) -> List[List[int]]:
        bst = BST()
        def build_bst(node):
            if not node:
                return
            bst.insert(node.val)
            build_bst(node.left)
            build_bst(node.right)
        build_bst(root)
        return bst.closest_nodes(queries)