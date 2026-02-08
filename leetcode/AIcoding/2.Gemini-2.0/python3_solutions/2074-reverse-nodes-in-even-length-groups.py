class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reverseEvenLengthGroups(self, head: ListNode) -> ListNode:
        dummy = ListNode(0)
        dummy.next = head
        curr = head
        prev = dummy
        k = 1
        while curr:
            group_len = 0
            temp = curr
            while temp and group_len < k:
                temp = temp.next
                group_len += 1

            if group_len % 2 == 0:

                next_group = temp

                group_head = curr
                group_tail = None

                prev.next = None

                prev_rev = None
                curr_rev = curr
                next_rev = None

                for _ in range(group_len):
                    next_rev = curr_rev.next
                    curr_rev.next = prev_rev
                    prev_rev = curr_rev
                    curr_rev = next_rev

                prev.next = prev_rev
                group_head.next = next_group
                prev = group_head
                curr = next_group

            else:
                for _ in range(group_len):
                    prev = curr
                    curr = curr.next
            k += 1
        return dummy.next