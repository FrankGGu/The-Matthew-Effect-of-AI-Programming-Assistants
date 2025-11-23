class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reorderList(self, head: ListNode) -> None:
        if not head or not head.next:
            return

        slow = head
        fast = head
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next

        second_half = slow.next
        slow.next = None

        prev = None
        curr = second_half
        while curr:
            next_node = curr.next
            curr.next = prev
            prev = curr
            curr = next_node

        second_half = prev

        first_half = head
        while second_half:
            first_next = first_half.next
            second_next = second_half.next

            first_half.next = second_half
            second_half.next = first_next

            first_half = first_next
            second_half = second_next