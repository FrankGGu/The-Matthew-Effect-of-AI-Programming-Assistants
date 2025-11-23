class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def recoverFromPreorder(self, traversal: str) -> TreeNode:
        stack = []
        i = 0
        while i < len(traversal):
            level = 0
            while i < len(traversal) and traversal[i] == '-':
                level += 1
                i += 1
            num = 0
            while i < len(traversal) and traversal[i].isdigit():
                num = num * 10 + int(traversal[i])
                i += 1
            node = TreeNode(num)
            if level == 0:
                root = node
                stack = [node]
            else:
                while len(stack) > level:
                    stack.pop()
                parent = stack[-1]
                if parent.left is None:
                    parent.left = node
                else:
                    parent.right = node
                stack.append(node)
        return root