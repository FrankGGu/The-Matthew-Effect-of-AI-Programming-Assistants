class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def insertionSortList(self, head: ListNode) -> ListNode:
        dummy = ListNode(0)
        dummy.next = head
        curr = head
        prev = dummy
        while curr:
            if curr.next and curr.next.val < curr.val:
                temp = curr.next
                curr.next = curr.next.next
                p = dummy
                while p.next and p.next.val < temp.val:
                    p = p.next
                temp.next = p.next
                p.next = temp
            else:
                curr = curr.next
        return dummy.next