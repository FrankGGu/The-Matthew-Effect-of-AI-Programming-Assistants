from collections import deque

class Solution:
    def countSubtreesWithMaxDistance(self, n: int, edges: list[list[int]]) -> list[int]:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u - 1].append(v - 1)
            adj[v - 1].append(u - 1)

        all_pairs_dist = [[float('inf')] * n for _ in range(n)]
        for i in range(n):
            all_pairs_dist[i][i] = 0
            q = deque([(i, 0)])
            visited_bfs = {i}
            while q:
                u, d = q.popleft()
                for v in adj[u]:
                    if v not in visited_bfs:
                        visited_bfs.add(v)
                        all_pairs_dist[i][v] = d + 1
                        q.append((v, d + 1))

        ans = [0] * n 

        for i in range(1, 1 << n):

            cities_in_subset = []
            for j in range(n):
                if (i >> j) & 1:
                    cities_in_subset.append(j)

            num_cities = len(cities_in_subset)

            if num_cities < 2:
                continue

            start_node = cities_in_subset[0]

            q_conn = deque([start_node])
            visited_conn = {start_node}
            count_visited_in_subset = 1

            while q_conn:
                u = q_conn.popleft()
                for v in adj[u]:
                    if (i >> v) & 1 and v not in visited_conn:
                        visited_conn.add(v)
                        count_visited_in_subset += 1
                        q_conn.append(v)

            if count_visited_in_subset != num_cities:
                continue

            max_dist_in_subset = 0
            for j in range(num_cities):
                for k in range(j + 1, num_cities):
                    u = cities_in_subset[j]
                    v = cities_in_subset[k]
                    max_dist_in_subset = max(max_dist_in_subset, all_pairs_dist[u][v])

            ans[max_dist_in_subset] += 1

        return ans[1:]