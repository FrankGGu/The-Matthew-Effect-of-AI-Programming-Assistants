class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reverseBetween(self, head: ListNode, left: int, right: int) -> ListNode:
        if not head or left == right:
            return head

        dummy = ListNode(0)
        dummy.next = head
        pre = dummy

        for _ in range(left - 1):
            pre = pre.next

        curr = pre.next
        for _ in range(right - left):
            nxt = curr.next
            curr.next = nxt.next
            nxt.next = pre.next
            pre.next = nxt

        return dummy.next