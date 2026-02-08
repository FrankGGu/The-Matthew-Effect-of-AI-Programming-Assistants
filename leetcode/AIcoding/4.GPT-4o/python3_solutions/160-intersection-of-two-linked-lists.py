class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> ListNode:
        if not headA or not headB:
            return None

        a, b = headA, headB
        while a != b:
            a = a.next if a else headB
            b = b.next if b else headA

        return a