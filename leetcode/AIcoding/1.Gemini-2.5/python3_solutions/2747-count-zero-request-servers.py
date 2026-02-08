import collections

class Solution:
    def countServers(self, n: int, logs: list[list[int]], queries: list[list[int]]) -> list[int]:
        indexed_queries = []
        for i, (q_time, duration) in enumerate(queries):
            indexed_queries.append((q_time, duration, i))

        logs.sort(key=lambda x: x[1])
        indexed_queries.sort(key=lambda x: x[0])

        ans = [0] * len(queries)
        server_counts = collections.Counter()

        log_ptr_left = 0
        log_ptr_right = 0

        for q_time, duration, original_idx in indexed_queries:
            window_start_time = q_time - duration

            while log_ptr_right < len(logs) and logs[log_ptr_right][1] <= q_time:
                server_id = logs[log_ptr_right][0]
                server_counts[server_id] += 1
                log_ptr_right += 1

            while log_ptr_left < len(logs) and logs[log_ptr_left][1] < window_start_time:
                server_id = logs[log_ptr_left][0]
                server_counts[server_id] -= 1
                if server_counts[server_id] == 0:
                    del server_counts[server_id]
                log_ptr_left += 1

            servers_with_requests = len(server_counts)
            ans[original_idx] = n - servers_with_requests

        return ans