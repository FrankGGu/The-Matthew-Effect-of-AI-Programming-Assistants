class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def removeZeroSumSublists(self, head: ListNode) -> ListNode:
        dummy = ListNode(0)
        dummy.next = head
        prefix_sum = 0
        seen = {0: dummy}

        curr = head
        while curr:
            prefix_sum += curr.val
            if prefix_sum in seen:
                prev = seen[prefix_sum]
                temp_sum = prefix_sum
                temp = prev.next
                while temp != curr:
                    temp_sum += temp.val
                    del seen[temp_sum]
                    temp = temp.next
                prev.next = curr.next
            else:
                seen[prefix_sum] = curr
            curr = curr.next

        return dummy.next