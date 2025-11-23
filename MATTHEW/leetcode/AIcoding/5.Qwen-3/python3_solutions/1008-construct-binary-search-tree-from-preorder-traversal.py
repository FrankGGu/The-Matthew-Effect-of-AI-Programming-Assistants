class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def bstFromPreorder(self, preorder: List[int]) -> TreeNode:
        if not preorder:
            return None

        root = TreeNode(preorder[0])
        stack = [root]

        for i in range(1, len(preorder)):
            current = preorder[i]
            node = TreeNode(current)
            prev = None

            while stack and stack[-1].val < current:
                prev = stack.pop()

            if prev:
                prev.right = node
            else:
                stack[-1].left = node

            stack.append(node)

        return root