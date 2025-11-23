class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def createBinaryTree(descriptions):
    from collections import defaultdict

    nodes = {}
    has_parent = set()

    for parent, child, is_left in descriptions:
        if parent not in nodes:
            nodes[parent] = TreeNode(parent)
        if child not in nodes:
            nodes[child] = TreeNode(child)

        if is_left:
            nodes[parent].left = nodes[child]
        else:
            nodes[parent].right = nodes[child]

        has_parent.add(child)

    for node in nodes.values():
        if node.val not in has_parent:
            return node