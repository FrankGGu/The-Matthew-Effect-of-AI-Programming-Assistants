class Solution:
    def splitListToParts(self, head: Optional[ListNode], k: int) -> List[Optional[ListNode]]:
        length = 0
        current = head
        while current:
            length += 1
            current = current.next

        part_size = length // k
        extra = length % k

        result = []
        current = head
        for i in range(k):
            result.append(current)
            size = part_size + (1 if i < extra else 0)
            for _ in range(size - 1):
                if current:
                    current = current.next
            if current:
                next_node = current.next
                current.next = None
                current = next_node

        return result