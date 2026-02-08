class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None

class Solution:
    def bookArrangement(self, head: ListNode) -> ListNode:
        dummy_even = ListNode(0)
        dummy_odd = ListNode(0)

        even_tail = dummy_even
        odd_tail = dummy_odd

        current = head
        while current:
            if current.val % 2 == 0:
                even_tail.next = current
                even_tail = even_tail.next
            else:
                odd_tail.next = current
                odd_tail = odd_tail.next
            current = current.next

        even_tail.next = dummy_odd.next
        odd_tail.next = None

        return dummy_even.next