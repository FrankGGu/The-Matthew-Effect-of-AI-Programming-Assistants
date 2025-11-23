class Solution:
    def rotateRight(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        if not head or not head.next or k == 0:
            return head

        length = 1
        curr = head
        while curr.next:
            curr = curr.next
            length += 1

        original_tail = curr

        k = k % length
        if k == 0:
            return head

        original_tail.next = head

        new_tail_pos = length - k - 1
        curr = head
        for _ in range(new_tail_pos):
            curr = curr.next

        new_tail = curr
        new_head = new_tail.next

        new_tail.next = None

        return new_head