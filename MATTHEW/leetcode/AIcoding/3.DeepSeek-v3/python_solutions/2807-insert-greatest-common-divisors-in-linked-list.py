class Solution:
    def insertGreatestCommonDivisors(self, head: Optional[ListNode]) -> Optional[ListNode]:
        def gcd(a, b):
            while b:
                a, b = b, a % b
            return a

        current = head
        while current and current.next:
            a = current.val
            b = current.next.val
            gcd_val = gcd(a, b)
            new_node = ListNode(gcd_val)
            new_node.next = current.next
            current.next = new_node
            current = new_node.next
        return head