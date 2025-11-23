class Solution:
    def reorderList(self, head: ListNode) -> None:
        if not head or not head.next:
            return

        slow = head
        fast = head
        while fast.next and fast.next.next:
            slow = slow.next
            fast = fast.next.next

        head1 = head
        head2 = slow.next
        slow.next = None

        prev = None
        curr = head2
        while curr:
            next_node = curr.next
            curr.next = prev
            prev = curr
            curr = next_node
        head2_reversed = prev

        p1 = head1
        p2 = head2_reversed
        while p1 and p2:
            p1_next = p1.next
            p2_next = p2.next

            p1.next = p2
            p2.next = p1_next

            p1 = p1_next
            p2 = p2_next