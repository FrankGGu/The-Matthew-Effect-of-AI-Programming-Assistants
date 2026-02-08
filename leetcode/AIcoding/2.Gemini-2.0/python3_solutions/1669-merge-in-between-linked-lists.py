class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def mergeInBetween(self, list1: ListNode, a: int, b: int, list2: ListNode) -> ListNode:
        curr = list1
        prev_a = None
        for _ in range(a):
            prev_a = curr
            curr = curr.next

        tail_b = curr
        for _ in range(b - a + 1):
            tail_b = tail_b.next

        prev_a.next = list2

        curr2 = list2
        while curr2.next:
            curr2 = curr2.next

        curr2.next = tail_b

        return list1