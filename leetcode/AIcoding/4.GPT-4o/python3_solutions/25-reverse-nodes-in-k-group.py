class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reverseKGroup(self, head: ListNode, k: int) -> ListNode:
        def reverseLinkedList(start, end):
            prev, curr = None, start
            while curr != end:
                next_node = curr.next
                curr.next = prev
                prev = curr
                curr = next_node
            return prev

        count = 0
        pointer = head
        while pointer and count < k:
            pointer = pointer.next
            count += 1
        if count == k:
            reversed_head = reverseLinkedList(head, pointer)
            head.next = self.reverseKGroup(pointer, k)
            return reversed_head
        return head