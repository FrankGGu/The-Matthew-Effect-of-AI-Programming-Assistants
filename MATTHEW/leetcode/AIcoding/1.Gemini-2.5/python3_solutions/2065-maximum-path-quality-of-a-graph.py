import collections

class Solution:
    def maxPathQuality(self, values: list[int], edges: list[list[int]], max_time: int) -> int:
        n = len(values)
        adj = collections.defaultdict(list)
        for u, v, t in edges:
            adj[u].append((v, t))
            adj[v].append((u, t))

        self.max_quality = 0

        visited_counts = [0] * n

        def dfs(node, current_time, current_quality):
            self.max_quality = max(self.max_quality, current_quality)

            for neighbor, travel_time in adj[node]:
                new_time = current_time + travel_time
                if new_time <= max_time:
                    is_new_node = (visited_counts[neighbor] == 0)

                    new_quality = current_quality + (values[neighbor] if is_new_node else 0)

                    visited_counts[neighbor] += 1

                    dfs(neighbor, new_time, new_quality)

                    visited_counts[neighbor] -= 1

        visited_counts[0] = 1
        dfs(0, 0, values[0])

        return self.max_quality