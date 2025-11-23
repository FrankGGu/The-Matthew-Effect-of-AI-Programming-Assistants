class Solution:
    def nodesBetweenCriticalPoints(self, head: Optional[ListNode]) -> List[int]:
        if not head or not head.next or not head.next.next:
            return [-1, -1]

        critical_points_indices = []

        prev_node = head
        curr_node = head.next
        current_index = 1 

        while curr_node.next:
            next_node = curr_node.next

            is_local_max = curr_node.val > prev_node.val and curr_node.val > next_node.val
            is_local_min = curr_node.val < prev_node.val and curr_node.val < next_node.val

            if is_local_max or is_local_min:
                critical_points_indices.append(current_index)

            prev_node = curr_node
            curr_node = next_node
            current_index += 1

        if len(critical_points_indices) < 2:
            return [-1, -1]

        min_distance = float('inf')
        max_distance = critical_points_indices[-1] - critical_points_indices[0]

        for i in range(1, len(critical_points_indices)):
            min_distance = min(min_distance, critical_points_indices[i] - critical_points_indices[i-1])

        return [min_distance, max_distance]