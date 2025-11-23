class Solution:
    def doubleIt(self, head: Optional[ListNode]) -> Optional[ListNode]:
        def reverse(node):
            prev = None
            while node:
                next_node = node.next
                node.next = prev
                prev = node
                node = next_node
            return prev

        reversed_head = reverse(head)
        carry = 0
        current = reversed_head
        prev = None
        while current:
            new_val = current.val * 2 + carry
            current.val = new_val % 10
            carry = new_val // 10
            prev = current
            current = current.next

        if carry > 0:
            prev.next = ListNode(carry)

        return reverse(reversed_head)