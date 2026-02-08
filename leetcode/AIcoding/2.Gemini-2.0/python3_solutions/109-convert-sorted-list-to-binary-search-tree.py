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
    def sortedListToBST(self, head: Optional[ListNode]) -> Optional[TreeNode]:
        def find_middle(head):
            slow, fast = head, head
            prev = None
            while fast and fast.next:
                prev = slow
                slow = slow.next
                fast = fast.next.next
            return prev, slow

        if not head:
            return None

        if not head.next:
            return TreeNode(head.val)

        prev, middle = find_middle(head)

        if prev:
            prev.next = None

        root = TreeNode(middle.val)

        if middle != head:
            root.left = self.sortedListToBST(head)
        else:
            root.left = None

        root.right = self.sortedListToBST(middle.next)

        return root