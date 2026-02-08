class Solution:
    def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> ListNode:
        if not headA or not headB:
            return None

        a_ptr = headA
        b_ptr = headB

        while a_ptr != b_ptr:
            a_ptr = headB if a_ptr is None else a_ptr.next
            b_ptr = headA if b_ptr is None else b_ptr.next

        return a_ptr