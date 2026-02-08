class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def partition(self, head: ListNode, x: int) -> ListNode:
        less_head = ListNode(0)
        greater_head = ListNode(0)
        less_tail = less_head
        greater_tail = greater_head

        curr = head
        while curr:
            if curr.val < x:
                less_tail.next = curr
                less_tail = curr
            else:
                greater_tail.next = curr
                greater_tail = curr
            curr = curr.next

        greater_tail.next = None
        less_tail.next = greater_head.next

        return less_head.next