class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def rotateRight(self, head: ListNode, k: int) -> ListNode:
        if not head:
            return None

        length = 0
        curr = head
        while curr:
            length += 1
            curr = curr.next

        k = k % length

        if k == 0:
            return head

        curr = head
        for _ in range(length - k - 1):
            curr = curr.next

        new_head = curr.next
        curr.next = None

        curr = new_head
        while curr.next:
            curr = curr.next

        curr.next = head

        return new_head