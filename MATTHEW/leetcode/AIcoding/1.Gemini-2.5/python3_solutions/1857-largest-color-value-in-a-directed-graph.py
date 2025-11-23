import collections

class Solution:
    def largestPathValue(self, colors: str, edges: List[List[int]]) -> int:
        n = len(colors)

        adj = collections.defaultdict(list)
        in_degree = [0] * n

        for u, v in edges:
            adj[u].append(v)
            in_degree[v] += 1

        # dp[node][color_index] stores the maximum count of 'color_index'
        # for any path ending at 'node'.
        # color_index 0-25 for 'a'-'z'
        dp = [[0] * 26 for _ in range(n)]

        q = collections.deque()

        # Initialize queue with all nodes having in-degree 0
        for i in range(n):
            if in_degree[i] == 0:
                q.append(i)

        max_color_value = 0
        visited_nodes = 0

        while q:
            u = q.popleft()
            visited_nodes += 1

            # Increment the count for the color of the current node u
            color_idx_u = ord(colors[u]) - ord('a')
            dp[u][color_idx_u] += 1

            # Update the global maximum color value found so far
            max_color_value = max(max_color_value, max(dp[u]))

            # Propagate DP values to neighbors
            for v in adj[u]:
                for c_idx in range(26):
                    dp[v][c_idx] = max(dp[v][c_idx], dp[u][c_idx])

                in_degree[v] -= 1
                if in_degree[v] == 0:
                    q.append(v)

        # If not all nodes were visited, it means there's a cycle
        # and thus an infinitely long path, so return -1.
        if visited_nodes < n:
            return -1
        else:
            return max_color_value