import math

class Solution:
    def shortestDistanceAfterRoadAdditionQueriesII(self, n: int, initial_roads: list[list[int]], queries: list[list[int]]) -> list[int]:
        INF = math.inf

        dist = [[INF] * n for _ in range(n)]
        for i in range(n):
            dist[i][i] = 0

        for u, v, w in initial_roads:
            dist[u][v] = min(dist[u][v], w)
            dist[v][u] = min(dist[v][u], w)

        for k in range(n):
            for i in range(n):
                for j in range(n):
                    if dist[i][k] != INF and dist[k][j] != INF:
                        dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])

        results = []

        for u_query, v_query, w_query in queries:
            dist[u_query][v_query] = min(dist[u_query][v_query], w_query)
            dist[v_query][u_query] = min(dist[v_query][u_query], w_query)

            for i in range(n):
                for j in range(n):
                    if dist[i][u_query] != INF and dist[v_query][j] != INF:
                        dist[i][j] = min(dist[i][j], dist[i][u_query] + w_query + dist[v_query][j])

                    if dist[i][v_query] != INF and dist[u_query][j] != INF:
                        dist[i][j] = min(dist[i][j], dist[i][v_query] + w_query + dist[u_query][j])

            current_total_shortest_distance = 0
            for i in range(n):
                for j in range(n):
                    if dist[i][j] != INF:
                        current_total_shortest_distance += dist[i][j]

            results.append(current_total_shortest_distance)

        return results