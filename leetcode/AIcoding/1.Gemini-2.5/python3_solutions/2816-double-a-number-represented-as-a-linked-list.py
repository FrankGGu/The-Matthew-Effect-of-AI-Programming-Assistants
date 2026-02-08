class Solution:
    def doubleIt(self, head: Optional[ListNode]) -> Optional[ListNode]:
        def dfs(node: Optional[ListNode]) -> int:
            if not node:
                return 0

            carry_from_next = dfs(node.next)

            doubled_val = node.val * 2 + carry_from_next
            node.val = doubled_val % 10
            return doubled_val // 10

        final_carry = dfs(head)

        if final_carry == 1:
            new_head = ListNode(1)
            new_head.next = head
            return new_head
        else:
            return head