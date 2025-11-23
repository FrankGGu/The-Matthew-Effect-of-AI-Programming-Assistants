class Solution:
    def mergeNodes(self, head: Optional[ListNode]) -> Optional[ListNode]:
        dummy = ListNode(0)
        current = dummy
        sum_nodes = 0
        node = head.next

        while node:
            if node.val == 0:
                current.next = ListNode(sum_nodes)
                current = current.next
                sum_nodes = 0
            else:
                sum_nodes += node.val
            node = node.next

        return dummy.next