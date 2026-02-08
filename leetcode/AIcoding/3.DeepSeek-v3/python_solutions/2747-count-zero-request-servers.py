class Solution:
    def countServers(self, n: int, logs: List[List[int]], x: int, queries: List[int]) -> List[int]:
        logs.sort(key=lambda log: log[1])
        queries_sorted = sorted((q, i) for i, q in enumerate(queries))
        res = [0] * len(queries)
        left = right = 0
        server_count = {}
        m = len(logs)

        for q, idx in queries_sorted:
            start = q - x
            end = q

            while right < m and logs[right][1] <= end:
                server_id = logs[right][0]
                server_count[server_id] = server_count.get(server_id, 0) + 1
                right += 1

            while left < m and logs[left][1] < start:
                server_id = logs[left][0]
                server_count[server_id] -= 1
                if server_count[server_id] == 0:
                    del server_count[server_id]
                left += 1

            res[idx] = n - len(server_count)

        return res