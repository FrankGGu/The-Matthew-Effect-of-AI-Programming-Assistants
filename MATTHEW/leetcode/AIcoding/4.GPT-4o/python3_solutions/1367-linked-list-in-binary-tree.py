class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def isSubPath(self, head: ListNode, root: TreeNode) -> bool:
        if not head:
            return True
        if not root:
            return False

        def dfs(node, curr):
            if not curr:
                return True
            if not node:
                return False
            if node.val != curr.val:
                return False
            return dfs(node.left, curr.next) or dfs(node.right, curr.next)

        return dfs(root, head) or self.isSubPath(head, root.left) or self.isSubPath(head, root.right)