class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def swapNodes(self, head: ListNode, k: int) -> ListNode:
        first = None
        second = None
        curr = head
        length = 0

        while curr:
            length += 1
            if length == k:
                first = curr
            curr = curr.next

        curr = head
        for i in range(length - k):
            curr = curr.next

        second = curr

        first.val, second.val = second.val, first.val

        return head