class Solution:
    def closestNode(self, head: Optional[ListNode], node1: int, node2: int) -> int:
        def getDistance(node, target):
            dist = 0
            while node:
                if node.val == target:
                    return dist
                node = node.next
                dist += 1
            return float('inf')

        min_dist = float('inf')
        result = -1
        current = head
        while current:
            d1 = getDistance(current, node1)
            d2 = getDistance(current, node2)
            total = d1 + d2
            if total < min_dist:
                min_dist = total
                result = current.val
            current = current.next
        return result