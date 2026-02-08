class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def removeZeroSumSublists(self, head: ListNode) -> ListNode:
        dummy = ListNode(0)
        dummy.next = head
        prefix_sum = {}
        current_sum = 0
        current = dummy

        while current:
            current_sum += current.val
            prefix_sum[current_sum] = current

            current = current.next

        current_sum = 0
        current = dummy

        while current:
            current_sum += current.val
            current.next = prefix_sum[current_sum].next
            current = current.next

        return dummy.next