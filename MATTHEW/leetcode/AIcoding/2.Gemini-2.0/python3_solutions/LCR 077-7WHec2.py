class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def sortList(self, head: ListNode) -> ListNode:
        if not head or not head.next:
            return head

        def get_mid(head):
            slow, fast = head, head.next
            while fast and fast.next:
                slow = slow.next
                fast = fast.next.next
            return slow

        def merge(left, right):
            dummy = ListNode(0)
            tail = dummy
            while left and right:
                if left.val < right.val:
                    tail.next = left
                    left = left.next
                else:
                    tail.next = right
                    right = right.next
                tail = tail.next
            if left:
                tail.next = left
            if right:
                tail.next = right
            return dummy.next

        mid = get_mid(head)
        right = mid.next
        mid.next = None

        left = self.sortList(head)
        right = self.sortList(right)

        return merge(left, right)