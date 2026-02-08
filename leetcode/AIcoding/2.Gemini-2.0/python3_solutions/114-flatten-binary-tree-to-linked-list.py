class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def flatten(self, root: TreeNode) -> None:
        def flatten_helper(node):
            if not node:
                return None

            left_tail = flatten_helper(node.left)
            right_tail = flatten_helper(node.right)

            if node.left:
                temp = node.right
                node.right = node.left
                node.left = None
                left_tail.right = temp

            if right_tail:
                return right_tail
            elif left_tail:
                return left_tail
            else:
                return node

        flatten_helper(root)