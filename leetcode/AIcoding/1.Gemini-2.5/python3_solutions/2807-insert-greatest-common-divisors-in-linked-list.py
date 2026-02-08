import math

class Solution:
    def insertGreatestCommonDivisors(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if not head or not head.next:
            return head

        curr = head
        while curr and curr.next:
            gcd_val = math.gcd(curr.val, curr.next.val)

            new_node = ListNode(gcd_val)

            new_node.next = curr.next
            curr.next = new_node

            curr = curr.next.next

        return head