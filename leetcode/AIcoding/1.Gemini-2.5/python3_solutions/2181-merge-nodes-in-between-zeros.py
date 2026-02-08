class Solution:
    def mergeNodes(self, head: Optional[ListNode]) -> Optional[ListNode]:
        current = head.next

        new_head = ListNode(0)
        new_current = new_head

        while current:
            current_sum = 0
            while current.val != 0:
                current_sum += current.val
                current = current.next

            new_current.next = ListNode(current_sum)
            new_current = new_current.next

            current = current.next

        return new_head.next