import heapq

class Solution:
    def processTasks(self, servers: list[int], tasks: list[int]) -> list[int]:
        n = len(servers)
        m = len(tasks)

        available_servers = []
        for i in range(n):
            heapq.heappush(available_servers, (servers[i], i))

        busy_servers = []

        ans = [0] * m
        time_pointer = 0

        for task_id in range(m):
            time_pointer = max(time_pointer, task_id)

            while busy_servers and busy_servers[0][0] <= time_pointer:
                finish_time, weight, server_idx = heapq.heappop(busy_servers)
                heapq.heappush(available_servers, (weight, server_idx))

            if not available_servers:
                next_finish_time, weight, server_idx = heapq.heappop(busy_servers)
                time_pointer = next_finish_time
                heapq.heappush(available_servers, (weight, server_idx))

                while busy_servers and busy_servers[0][0] <= time_pointer:
                    finish_time, weight, server_idx = heapq.heappop(busy_servers)
                    heapq.heappush(available_servers, (weight, server_idx))

            weight, server_idx = heapq.heappop(available_servers)
            ans[task_id] = server_idx

            task_finish_time = time_pointer + tasks[task_id]
            heapq.heappush(busy_servers, (task_finish_time, weight, server_idx))

        return ans