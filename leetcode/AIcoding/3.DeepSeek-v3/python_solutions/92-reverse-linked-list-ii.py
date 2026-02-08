class Solution:
    def reverseBetween(self, head: Optional[ListNode], left: int, right: int) -> Optional[ListNode]:
        if not head or left == right:
            return head

        dummy = ListNode(0, head)
        prev = dummy

        for _ in range(left - 1):
            prev = prev.next

        current = prev.next
        next_node = None

        for _ in range(right - left + 1):
            temp = current.next
            current.next = next_node
            next_node = current
            current = temp

        prev.next.next = current
        prev.next = next_node

        return dummy.next