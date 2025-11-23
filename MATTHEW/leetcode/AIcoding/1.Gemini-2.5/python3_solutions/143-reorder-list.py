class Solution:
    def reorderList(self, head: ListNode) -> None:
        if not head or not head.next:
            return

        slow = head
        fast = head.next
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next

        first_half_head = head
        second_half_head = slow.next
        slow.next = None

        prev = None
        curr = second_half_head
        while curr:
            next_node = curr.next
            curr.next = prev
            prev = curr
            curr = next_node

        second_half_reversed_head = prev

        p1 = first_half_head
        p2 = second_half_reversed_head

        while p2:
            temp1 = p1.next
            temp2 = p2.next

            p1.next = p2
            p2.next = temp1

            p1 = temp1
            p2 = temp2