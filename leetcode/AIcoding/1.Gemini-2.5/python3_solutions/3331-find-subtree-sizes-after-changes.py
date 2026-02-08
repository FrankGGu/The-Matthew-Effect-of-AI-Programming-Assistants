from typing import List

class Solution:
    def findSubtreeSizes(self, n: int, edges: List[List[int]], queries: List[List[int]]) -> List[int]:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        entry_time = [0] * n
        exit_time = [0] * n
        timer = 0

        node_colors = [0] * n 

        segment_tree = [0] * (4 * n)

        def dfs(u, p):
            nonlocal timer
            entry_time[u] = timer
            timer += 1
            for v in adj[u]:
                if v != p:
                    dfs(v, u)
            exit_time[u] = timer

        dfs(0, -1)

        def update(node_idx, start, end, target_idx, val):
            if start == end:
                segment_tree[node_idx] = val
                return

            mid = (start + end) // 2
            if target_idx <= mid:
                update(2 * node_idx, start, mid, target_idx, val)
            else:
                update(2 * node_idx + 1, mid + 1, end, target_idx, val)

            segment_tree[node_idx] = segment_tree[2 * node_idx] + segment_tree[2 * node_idx + 1]

        def query(node_idx, start, end, l, r):
            if r < start or end < l:
                return 0

            if l <= start and end <= r:
                return segment_tree[node_idx]

            mid = (start + end) // 2
            p1 = query(2 * node_idx, start, mid, l, r)
            p2 = query(2 * node_idx + 1, mid + 1, end, l, r)
            return p1 + p2

        results = []
        for q_type, node in queries:
            if q_type == 0:
                node_colors[node] = 1 - node_colors[node]
                update(1, 0, n - 1, entry_time[node], node_colors[node])
            else:
                ans = query(1, 0, n - 1, entry_time[node], exit_time[node] - 1)
                results.append(ans)

        return results