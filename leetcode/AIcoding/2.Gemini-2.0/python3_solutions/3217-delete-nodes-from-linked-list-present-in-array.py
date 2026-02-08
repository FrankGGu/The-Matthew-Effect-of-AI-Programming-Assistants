class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def deleteNodes(self, head: ListNode, val: list[int]) -> ListNode:
        val_set = set(val)
        dummy = ListNode(0)
        dummy.next = head
        curr = dummy

        while curr and curr.next:
            if curr.next.val in val_set:
                curr.next = curr.next.next
            else:
                curr = curr.next

        return dummy.next