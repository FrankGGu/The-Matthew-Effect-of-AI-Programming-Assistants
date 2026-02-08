class Solution:
    def trainingPlan(self, head: ListNode, arr: List[int]) -> ListNode:
        dummy = ListNode(0)
        dummy.next = head
        prev = dummy
        curr = head

        for val in arr:
            while curr and curr.val != val:
                prev = curr
                curr = curr.next

            if curr:
                prev.next = curr.next
                curr.next = head
                head = curr
                dummy.next = head
                curr = prev.next
            else:
                curr = prev.next

        return head