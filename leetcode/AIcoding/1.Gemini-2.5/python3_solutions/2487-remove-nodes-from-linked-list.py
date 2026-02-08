class Solution:
    def removeNodes(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if not head:
            return None

        modified_next = self.removeNodes(head.next)

        if not modified_next or head.val >= modified_next.val:
            head.next = modified_next
            return head
        else:
            return modified_next