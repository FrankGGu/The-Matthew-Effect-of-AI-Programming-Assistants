import collections

class Solution:
    def recaptureStronghold(self, n: int, edges: list[list[int]], values: list[int], k: int) -> int:
        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        self.max_overall_sum = -float('inf')
        if n > 0:
            self.max_overall_sum = max(values)

        INVALID_SUM = -float('inf')

        def dfs(u, p):
            dp_u_current = [INVALID_SUM] * (k + 1)
            dp_u_current[0] = values[u]

            self.max_overall_sum = max(self.max_overall_sum, dp_u_current[0])

            for v in adj[u]:
                if v == p:
                    continue

                dp_v = dfs(v, u)

                prefix_max_dp_u = [INVALID_SUM] * (k + 1)
                current_max_val = INVALID_SUM
                for l1 in range(k + 1):
                    current_max_val = max(current_max_val, dp_u_current[l1])
                    prefix_max_dp_u[l1] = current_max_val

                for l2 in range(k + 1):
                    if dp_v[l2] == INVALID_SUM:
                        continue

                    max_l1_len = k - 1 - l2

                    if max_l1_len >= 0:
                        max_val_l1_from_prev_branches = prefix_max_dp_u[min(k, max_l1_len)]

                        if max_val_l1_from_prev_branches != INVALID_SUM:
                            self.max_overall_sum = max(self.max_overall_sum, max_val_l1_from_prev_branches + dp_v[l2])

                for l in range(k):
                    if dp_v[l] == INVALID_SUM:
                        continue

                    new_len = l + 1
                    if new_len <= k:
                        dp_u_current[new_len] = max(dp_u_current[new_len], values[u] + dp_v[l])

            for l in range(1, k + 1):
                if dp_u_current[l] != INVALID_SUM:
                    self.max_overall_sum = max(self.max_overall_sum, dp_u_current[l])

            return dp_u_current

        dfs(0, -1)

        return self.max_overall_sum