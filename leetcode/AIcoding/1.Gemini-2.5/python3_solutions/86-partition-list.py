class Solution:
    def partition(self, head: Optional[ListNode], x: int) -> Optional[ListNode]:
        less_head = ListNode(0)
        greater_equal_head = ListNode(0)

        less_curr = less_head
        greater_equal_curr = greater_equal_head

        current = head
        while current:
            if current.val < x:
                less_curr.next = current
                less_curr = less_curr.next
            else:
                greater_equal_curr.next = current
                greater_equal_curr = greater_equal_curr.next
            current = current.next

        less_curr.next = greater_equal_head.next
        greater_equal_curr.next = None

        return less_head.next