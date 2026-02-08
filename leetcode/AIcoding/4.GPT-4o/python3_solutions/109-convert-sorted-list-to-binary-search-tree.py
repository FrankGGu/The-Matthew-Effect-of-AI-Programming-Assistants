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
    def sortedListToBST(self, head: ListNode) -> TreeNode:
        def findMid(left, right):
            slow = left
            fast = left
            while fast != right and fast.next != right:
                slow = slow.next
                fast = fast.next.next
            return slow

        def convertListToBST(left, right):
            if left == right:
                return None
            mid = findMid(left, right)
            node = TreeNode(mid.val)
            node.left = convertListToBST(left, mid)
            node.right = convertListToBST(mid.next, right)
            return node

        return convertListToBST(head, None)