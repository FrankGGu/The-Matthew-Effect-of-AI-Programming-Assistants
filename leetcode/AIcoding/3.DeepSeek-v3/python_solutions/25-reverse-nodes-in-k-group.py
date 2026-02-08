class Solution:
    def reverseKGroup(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        dummy = ListNode(0)
        dummy.next = head
        prev = dummy

        while head:
            tail = prev
            for _ in range(k):
                tail = tail.next
                if not tail:
                    return dummy.next

            next_group = tail.next
            head, tail = self.reverse(head, tail)
            prev.next = head
            tail.next = next_group
            prev = tail
            head = tail.next

        return dummy.next

    def reverse(self, head, tail):
        prev = tail.next
        curr = head
        while prev != tail:
            next_node = curr.next
            curr.next = prev
            prev = curr
            curr = next_node
        return tail, head