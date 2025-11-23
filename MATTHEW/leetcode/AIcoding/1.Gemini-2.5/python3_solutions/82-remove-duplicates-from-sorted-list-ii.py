class Solution:
    def deleteDuplicates(self, head: Optional[ListNode]) -> Optional[ListNode]:
        dummy = ListNode(0, head)
        prev = dummy
        curr = head

        while curr and curr.next:
            if curr.val == curr.next.val:
                # Skip all nodes with the same value
                while curr.next and curr.val == curr.next.val:
                    curr = curr.next
                # After the loop, curr is the last node in the duplicate sequence
                # prev.next should bypass all these duplicates
                prev.next = curr.next
                # Move curr to the next distinct node
                curr = curr.next
            else:
                # If no duplicate, just move prev and curr forward
                prev = prev.next
                curr = curr.next

        return dummy.next