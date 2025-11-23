class Solution:
    def reverseEvenLengthGroups(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if not head or not head.next:
            return head

        dummy = ListNode(0, head)
        prev = dummy
        group_size = 1

        while prev.next:
            node = prev
            n = 0

            for _ in range(group_size):
                if not node.next:
                    break
                node = node.next
                n += 1

            if n % 2 == 0:
                curr = prev.next
                next_node = None
                tail = curr

                for _ in range(n):
                    temp = curr.next
                    curr.next = next_node
                    next_node = curr
                    curr = temp

                prev.next = next_node
                tail.next = curr
                prev = tail
            else:
                for _ in range(n):
                    prev = prev.next

            group_size += 1

        return dummy.next