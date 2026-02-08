class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def deleteNodes(self, head: ListNode, to_delete: List[int]) -> ListNode:
        to_delete_set = set(to_delete)
        dummy = ListNode(0)
        dummy.next = head
        prev = dummy

        while head:
            if head.val in to_delete_set:
                prev.next = head.next
            else:
                prev = head
            head = head.next

        return dummy.next