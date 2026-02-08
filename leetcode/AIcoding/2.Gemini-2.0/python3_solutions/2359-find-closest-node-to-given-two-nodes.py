from collections import deque

class Solution:
    def closestMeetingNode(self, edges: list[int], node1: int, node2: int) -> int:
        n = len(edges)

        def bfs(start_node):
            dist = [-1] * n
            dist[start_node] = 0
            q = deque([start_node])
            while q:
                node = q.popleft()
                neighbor = edges[node]
                if neighbor != -1 and dist[neighbor] == -1:
                    dist[neighbor] = dist[node] + 1
                    q.append(neighbor)
            return dist

        dist1 = bfs(node1)
        dist2 = bfs(node2)

        min_dist = float('inf')
        closest_node = -1

        for i in range(n):
            if dist1[i] != -1 and dist2[i] != -1:
                max_dist = max(dist1[i], dist2[i])
                if max_dist < min_dist:
                    min_dist = max_dist
                    closest_node = i
                elif max_dist == min_dist and i < closest_node:
                    closest_node = i

        return closest_node