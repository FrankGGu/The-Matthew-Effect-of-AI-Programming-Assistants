class Solution:
    def trainingPlan(self, head: ListNode, target: ListNode) -> ListNode:
        dummy = ListNode(-1)
        dummy.next = head
        pre = dummy
        while pre.next != target:
            pre = pre.next

        after = target.next
        pre.next = after

        p = head
        while p.next:
            p = p.next

        p.next = head
        target.next = None

        return target