class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def splitListToParts(self, root: ListNode, k: int):
        length = 0
        current = root
        while current:
            length += 1
            current = current.next

        part_length, extra_parts = divmod(length, k)
        parts = []
        current = root

        for i in range(k):
            parts.append(current)
            current_part_length = part_length + (1 if i < extra_parts else 0)
            for j in range(current_part_length - 1):
                if current:
                    current = current.next
            if current:
                next_part = current.next
                current.next = None
                current = next_part

        return parts