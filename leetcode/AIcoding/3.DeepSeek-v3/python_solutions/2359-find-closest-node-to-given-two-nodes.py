class Solution:
    def closestMeetingNode(self, edges: List[int], node1: int, node2: int) -> int:
        def get_distances(start):
            dist = {}
            current = start
            distance = 0
            while current != -1 and current not in dist:
                dist[current] = distance
                current = edges[current]
                distance += 1
            return dist

        dist1 = get_distances(node1)
        dist2 = get_distances(node2)

        min_max_dist = float('inf')
        result = -1

        for node in dist1:
            if node in dist2:
                current_max = max(dist1[node], dist2[node])
                if current_max < min_max_dist or (current_max == min_max_dist and node < result):
                    min_max_dist = current_max
                    result = node

        return result