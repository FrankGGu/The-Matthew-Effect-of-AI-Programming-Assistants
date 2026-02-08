from typing import Optional

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
    def isSubPath(self, head: Optional[ListNode], root: Optional[TreeNode]) -> bool:
        if not head:
            return True
        if not root:
            return False

        # Check if the linked list matches starting from the current root
        # OR if it matches starting from any node in the left subtree
        # OR if it matches starting from any node in the right subtree
        return self._dfs_match(head, root) or \
               self.isSubPath(head, root.left) or \
               self.isSubPath(head, root.right)

    def _dfs_match(self, head: Optional[ListNode], root: Optional[TreeNode]) -> bool:
        # If we have successfully matched all nodes in the linked list
        if not head:
            return True

        # If we ran out of tree nodes or the current node's value doesn't match
        if not root or head.val != root.val:
            return False

        # If current values match, try to match the rest of the list
        # with either the left or right child of the current tree node
        return self._dfs_match(head.next, root.left) or \
               self._dfs_match(head.next, root.right)