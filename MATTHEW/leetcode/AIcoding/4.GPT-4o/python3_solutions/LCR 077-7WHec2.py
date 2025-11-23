class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def sortList(self, head: ListNode) -> ListNode:
        if not head or not head.next:
            return head

        def split(head):
            slow = fast = head
            while fast and fast.next:
                slow = slow.next
                fast = fast.next.next
            mid = slow
            prev = head
            while prev.next != mid:
                prev = prev.next
            prev.next = None
            return head, mid

        def merge(left, right):
            dummy = ListNode(0)
            current = dummy
            while left and right:
                if left.val < right.val:
                    current.next = left
                    left = left.next
                else:
                    current.next = right
                    right = right.next
                current = current.next
            current.next = left if left else right
            return dummy.next

        left, right = split(head)
        return merge(self.sortList(left), self.sortList(right))