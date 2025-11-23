class Solution:
    def nodesBetweenCriticalPoints(self, head: Optional[ListNode]) -> List[int]:
        if not head or not head.next or not head.next.next:
            return [-1, -1]

        prev = head
        curr = head.next
        next_node = curr.next
        critical_indices = []
        index = 1

        while next_node:
            if (curr.val > prev.val and curr.val > next_node.val) or (curr.val < prev.val and curr.val < next_node.val):
                critical_indices.append(index)
            prev = curr
            curr = next_node
            next_node = next_node.next
            index += 1

        if len(critical_indices) < 2:
            return [-1, -1]

        min_dist = float('inf')
        for i in range(1, len(critical_indices)):
            min_dist = min(min_dist, critical_indices[i] - critical_indices[i-1])

        max_dist = critical_indices[-1] - critical_indices[0]

        return [min_dist, max_dist]