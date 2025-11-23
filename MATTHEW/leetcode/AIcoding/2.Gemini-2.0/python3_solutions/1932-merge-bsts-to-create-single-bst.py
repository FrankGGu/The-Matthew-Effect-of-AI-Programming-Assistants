class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def canMerge(self, trees: list[TreeNode]) -> TreeNode:
        nodes = {tree.val: tree for tree in trees}
        children = set()
        for tree in trees:
            if tree.left:
                children.add(tree.left.val)
            if tree.right:
                children.add(tree.right.val)

        roots = []
        for tree in trees:
            if tree.val not in children:
                roots.append(tree)

        if len(roots) != 1:
            return None

        root = roots[0]

        def isValidBST(node, low, high):
            if not node:
                return True

            if not (low < node.val < high):
                return False

            return isValidBST(node.left, low, node.val) and isValidBST(node.right, node.val, high)

        def merge(node, nodes):
            if not node:
                return

            if node.val in nodes:
                newNode = nodes[node.val]
                del nodes[node.val]
                newNode.left, newNode.right = node.left, node.right
                node.left, node.right = newNode.left, newNode.right
                merge(node.left, nodes)
                merge(node.right, nodes)

        merge(root, nodes)

        if nodes:
            return None

        if not isValidBST(root, float('-inf'), float('inf')):
            return None

        def countNodes(node):
            if not node:
                return 0
            return 1 + countNodes(node.left) + countNodes(node.right)

        totalNodes = 0
        for tree in trees:
            def count(node):
                if not node:
                    return 0
                return 1 + count(node.left) + count(node.right)
            totalNodes += count(tree)

        if countNodes(root) != totalNodes:
            return None

        return root