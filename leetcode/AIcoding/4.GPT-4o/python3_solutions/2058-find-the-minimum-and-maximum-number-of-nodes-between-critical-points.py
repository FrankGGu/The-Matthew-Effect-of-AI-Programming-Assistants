class Solution:
    def nodesBetweenCriticalPoints(self, head: ListNode) -> List[int]:
        critical_points = []
        index = 0
        prev, curr = head, head.next

        while curr and curr.next:
            if (prev.val < curr.val > curr.next.val) or (prev.val > curr.val < curr.next.val):
                critical_points.append(index + 1)
            prev = curr
            curr = curr.next
            index += 1

        if len(critical_points) < 2:
            return [-1, -1]

        min_distance = float('inf')
        for i in range(1, len(critical_points)):
            min_distance = min(min_distance, critical_points[i] - critical_points[i - 1])

        return [min_distance, critical_points[-1] - critical_points[0]]