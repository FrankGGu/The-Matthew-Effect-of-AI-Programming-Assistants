class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def isSubPath(self, head: ListNode, root: TreeNode) -> bool:
        def dfs(node, curr):
            if not curr:
                return True
            if not node:
                return False
            if node.val != curr.val:
                return False
            return dfs(node.left, curr.next) and dfs(node.right, curr.next)

        def traverse(node):
            if not node:
                return False
            if node.val == head.val and dfs(node, head):
                return True
            return traverse(node.left) or traverse(node.right)

        return traverse(root)