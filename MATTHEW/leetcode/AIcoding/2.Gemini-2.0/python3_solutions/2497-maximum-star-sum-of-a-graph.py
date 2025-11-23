class Solution:
    def maxStarSum(self, vals: List[int], edges: List[List[int]], k: int) -> int:
        n = len(vals)
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        max_sum = float('-inf')
        for i in range(n):
            neighbors = adj[i]
            neighbor_vals = []
            for neighbor in neighbors:
                neighbor_vals.append(vals[neighbor])
            neighbor_vals.sort(reverse=True)

            current_sum = vals[i]
            count = 0
            for val in neighbor_vals:
                if val > 0 and count < k:
                    current_sum += val
                    count += 1
                else:
                    break

            max_sum = max(max_sum, current_sum)

        return max_sum