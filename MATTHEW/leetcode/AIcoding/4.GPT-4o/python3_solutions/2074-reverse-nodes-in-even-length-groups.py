class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reverseEvenLengthGroups(self, head: ListNode) -> ListNode:
        if not head:
            return head

        current = head
        length = 1
        group_start = None
        group_end = None
        group_counter = 0
        prev_tail = None

        while current:
            group_counter += 1
            group_start = current
            count = 0

            while current and count < length:
                count += 1
                current = current.next

            if count % 2 == 0:
                group_end = group_start
                for _ in range(count):
                    temp = group_start.next
                    group_start.next = prev_tail
                    prev_tail = group_start
                    group_start = temp

                if prev_tail:
                    if group_counter == 1:
                        head = prev_tail
                    else:
                        prev_tail_end = prev_tail
                        while prev_tail_end.next:
                            prev_tail_end = prev_tail_end.next
                        prev_tail_end.next = group_end

                group_end.next = current
                prev_tail = None

            length += 1

        return head