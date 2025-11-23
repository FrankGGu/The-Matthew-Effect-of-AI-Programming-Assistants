class Solution:
    def swapNodes(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        node1 = head
        for _ in range(k - 1):
            node1 = node1.next

        slow = head
        fast = node1

        while fast.next:
            slow = slow.next
            fast = fast.next

        node2 = slow

        node1.val, node2.val = node2.val, node1.val

        return head