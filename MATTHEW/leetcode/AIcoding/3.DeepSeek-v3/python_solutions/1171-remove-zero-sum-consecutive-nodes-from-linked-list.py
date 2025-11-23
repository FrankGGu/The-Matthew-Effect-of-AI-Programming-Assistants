class Solution:
    def removeZeroSumSublists(self, head: Optional[ListNode]) -> Optional[ListNode]:
        dummy = ListNode(0)
        dummy.next = head
        prefix = 0
        seen = {}
        seen[0] = dummy
        current = head

        while current:
            prefix += current.val
            if prefix in seen:
                to_delete = seen[prefix].next
                temp_sum = prefix
                while to_delete != current:
                    temp_sum += to_delete.val
                    del seen[temp_sum]
                    to_delete = to_delete.next
                seen[prefix].next = current.next
            else:
                seen[prefix] = current
            current = current.next

        return dummy.next