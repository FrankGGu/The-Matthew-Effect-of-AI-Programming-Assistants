class Solution:
    def insertionSortList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if not head or not head.next:
            return head

        dummy = ListNode(0)
        curr = head

        while curr:
            next_node = curr.next

            prev_insert = dummy
            while prev_insert.next and prev_insert.next.val < curr.val:
                prev_insert = prev_insert.next

            curr.next = prev_insert.next
            prev_insert.next = curr

            curr = next_node

        return dummy.next