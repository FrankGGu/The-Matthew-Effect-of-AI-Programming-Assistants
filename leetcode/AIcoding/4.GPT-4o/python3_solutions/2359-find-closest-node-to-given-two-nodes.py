class Solution:
    def closestMeetingNode(self, edges: List[int], node1: int, node2: int) -> int:
        def bfs(start):
            distance = [-1] * len(edges)
            queue = deque([start])
            distance[start] = 0
            while queue:
                curr = queue.popleft()
                if edges[curr] != -1:
                    next_node = edges[curr]
                    if distance[next_node] == -1:
                        distance[next_node] = distance[curr] + 1
                        queue.append(next_node)
            return distance

        dist1 = bfs(node1)
        dist2 = bfs(node2)

        min_distance = float('inf')
        result_node = -1

        for i in range(len(edges)):
            if dist1[i] != -1 and dist2[i] != -1:
                max_dist = max(dist1[i], dist2[i])
                if max_dist < min_distance:
                    min_distance = max_dist
                    result_node = i

        return result_node