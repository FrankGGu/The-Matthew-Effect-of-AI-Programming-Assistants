class Solution:
    def trainingPlan(self, head: ListNode, target: ListNode) -> ListNode:
        if head == target:
            return head.next

        prev = None
        curr = head
        while curr != target:
            prev = curr
            curr = curr.next

        prev.next = target.next

        tail = head
        while tail.next:
            tail = tail.next

        tail.next = head

        return target.next