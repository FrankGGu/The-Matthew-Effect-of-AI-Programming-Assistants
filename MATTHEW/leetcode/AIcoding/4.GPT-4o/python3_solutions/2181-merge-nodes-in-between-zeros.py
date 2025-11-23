class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def mergeNodes(self, head: ListNode) -> ListNode:
        dummy = ListNode(0)
        current = dummy
        sum_value = 0
        head = head.next

        while head:
            if head.val == 0:
                if sum_value > 0:
                    current.next = ListNode(sum_value)
                    current = current.next
                    sum_value = 0
            else:
                sum_value += head.val
            head = head.next

        return dummy.next