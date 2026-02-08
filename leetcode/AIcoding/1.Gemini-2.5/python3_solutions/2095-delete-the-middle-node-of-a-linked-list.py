class Solution:
    def deleteMiddle(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if head is None or head.next is None:
            return None

        slow_prev = None
        slow_curr = head
        fast = head

        while fast is not None and fast.next is not None:
            slow_prev = slow_curr
            slow_curr = slow_curr.next
            fast = fast.next.next

        if slow_prev is not None:
            slow_prev.next = slow_curr.next

        return head