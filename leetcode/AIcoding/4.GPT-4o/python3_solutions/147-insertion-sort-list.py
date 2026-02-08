class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def insertionSortList(self, head: ListNode) -> ListNode:
        if not head:
            return head

        sorted_head = ListNode(0)

        current = head
        while current:
            prev = sorted_head
            next_node = current.next

            while prev.next and prev.next.val < current.val:
                prev = prev.next

            current.next = prev.next
            prev.next = current

            current = next_node

        return sorted_head.next