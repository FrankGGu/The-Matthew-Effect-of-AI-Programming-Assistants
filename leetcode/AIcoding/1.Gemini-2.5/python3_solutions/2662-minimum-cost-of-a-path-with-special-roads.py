import heapq

class Solution:
    def minimumCost(self, start: list[int], end: list[int], specialRoads: list[list[int]]) -> int:

        all_points = set()
        all_points.add(tuple(start))
        all_points.add(tuple(end))
        for x1, y1, x2, y2, _ in specialRoads:
            all_points.add((x1, y1))
            all_points.add((x2, y2))

        point_list = list(all_points)
        num_points = len(point_list)
        point_to_idx = {point: i for i, point in enumerate(point_list)}

        start_idx = point_to_idx[tuple(start)]
        end_idx = point_to_idx[tuple(end)]

        adj_matrix = [[float('inf')] * num_points for _ in range(num_points)]

        for i in range(num_points):
            adj_matrix[i][i] = 0
            p1_x, p1_y = point_list[i]
            for j in range(i + 1, num_points):
                p2_x, p2_y = point_list[j]
                manhattan_dist = abs(p1_x - p2_x) + abs(p1_y - p2_y)
                adj_matrix[i][j] = manhattan_dist
                adj_matrix[j][i] = manhattan_dist

        for x1, y1, x2, y2, cost_special in specialRoads:
            p1_idx = point_to_idx[(x1, y1)]
            p2_idx = point_to_idx[(x2, y2)]
            adj_matrix[p1_idx][p2_idx] = min(adj_matrix[p1_idx][p2_idx], cost_special)

        dist = [float('inf')] * num_points
        dist[start_idx] = 0

        pq = [(0, start_idx)]

        while pq:
            d, u_idx = heapq.heappop(pq)

            if d > dist[u_idx]:
                continue

            for v_idx in range(num_points):
                if dist[u_idx] + adj_matrix[u_idx][v_idx] < dist[v_idx]:
                    dist[v_idx] = dist[u_idx] + adj_matrix[u_idx][v_idx]
                    heapq.heappush(pq, (dist[v_idx], v_idx))

        return dist[end_idx]