class Solution:
    def splitListToParts(self, head: ListNode, k: int) -> list[ListNode]:
        n = 0
        current = head
        while current:
            n += 1
            current = current.next

        q = n // k
        r = n % k

        result = [None] * k

        current_node = head
        for i in range(k):
            result[i] = current_node

            part_length = q + (1 if i < r else 0)

            if current_node:
                for _ in range(part_length - 1):
                    if current_node:
                        current_node = current_node.next
                    else:
                        break

                if current_node:
                    next_head = current_node.next
                    current_node.next = None
                    current_node = next_head

        return result