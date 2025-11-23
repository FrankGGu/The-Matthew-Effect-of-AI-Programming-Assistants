class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reverseKGroup(self, head: ListNode, k: int) -> ListNode:
        dummy = ListNode(0)
        dummy.next = head
        pre = dummy
        curr = head

        while curr:
            tail = pre
            for _ in range(k):
                tail = tail.next
                if not tail:
                    return dummy.next

            nxt = tail.next

            def reverseList(head, tail):
                prev = tail.next
                curr = head
                while prev != tail:
                    nxt = curr.next
                    curr.next = prev
                    prev = curr
                    curr = nxt
                return tail, head

            head, tail = reverseList(pre.next, tail)
            pre.next = head
            tail.next = nxt
            pre = tail
            curr = nxt

        return dummy.next