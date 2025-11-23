import collections

class Solution:
    def minimumCost(self, source: str, target: str, original: list[str], changed: list[str], cost: list[int]) -> int:
        N = len(source)

        all_strings = set()
        for s in original:
            all_strings.add(s)
        for s in changed:
            all_strings.add(s)

        str_to_id = {s: i for i, s in enumerate(sorted(list(all_strings)))}
        id_to_str = {i: s for s, i in str_to_id.items()}
        num_unique_strings = len(all_strings)

        dist = [[float('inf')] * num_unique_strings for _ in range(num_unique_strings)]

        for i in range(num_unique_strings):
            dist[i][i] = 0

        for o_str, c_str, k_cost in zip(original, changed, cost):
            o_id = str_to_id[o_str]
            c_id = str_to_id[c_str]
            dist[o_id][c_id] = min(dist[o_id][c_id], k_cost)

        for k_id in range(num_unique_strings):
            for i_id in range(num_unique_strings):
                for j_id in range(num_unique_strings):
                    if dist[i_id][k_id] != float('inf') and dist[k_id][j_id] != float('inf'):
                        dist[i_id][j_id] = min(dist[i_id][j_id], dist[i_id][k_id] + dist[k_id][j_id])

        min_conversion_cost_final = collections.defaultdict(lambda: float('inf'))
        for i_id in range(num_unique_strings):
            for j_id in range(num_unique_strings):
                if dist[i_id][j_id] != float('inf'):
                    min_conversion_cost_final[(id_to_str[i_id], id_to_str[j_id])] = dist[i_id][j_id]

        max_len_conversion = 0
        for s in original:
            max_len_conversion = max(max_len_conversion, len(s))
        for s in changed:
            max_len_conversion = max(max_len_conversion, len(s))

        dp = [float('inf')] * (N + 1)
        dp[N] = 0 

        for i in range(N - 1, -1, -1):
            if source[i] == target[i]:
                if dp[i+1] != float('inf'):
                    dp[i] = min(dp[i], dp[i+1])

            for l in range(1, max_len_conversion + 1):
                if i + l <= N:
                    sub_source = source[i : i+l]
                    sub_target = target[i : i+l]

                    conversion_cost = min_conversion_cost_final[(sub_source, sub_target)]

                    if conversion_cost != float('inf') and dp[i+l] != float('inf'):
                        dp[i] = min(dp[i], conversion_cost + dp[i+l])

        return dp[0] if dp[0] != float('inf') else -1