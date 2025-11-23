class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def mergeNodes(self, head: ListNode) -> ListNode:
        dummy = ListNode(0)
        curr = dummy
        sum_val = 0
        node = head.next
        while node:
            if node.val == 0:
                curr.next = ListNode(sum_val)
                curr = curr.next
                sum_val = 0
            else:
                sum_val += node.val
            node = node.next
        return dummy.next