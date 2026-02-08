class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def insertGCD(self, head: ListNode) -> ListNode:
        if not head:
            return None

        current = head
        while current and current.next:
            gcd_value = self.gcd(current.val, current.next.val)
            new_node = ListNode(gcd_value, current.next)
            current.next = new_node
            current = new_node.next

        return head

    def gcd(self, a: int, b: int) -> int:
        while b:
            a, b = b, a % b
        return a