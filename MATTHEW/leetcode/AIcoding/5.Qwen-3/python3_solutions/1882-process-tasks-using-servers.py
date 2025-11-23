import heapq

class Solution:
    def assignTasks(self, servers: List[int], tasks: List[int]) -> List[int]:
        available = [(servers[i], i) for i in range(len(servers))]
        heapq.heapify(available)

        busy = []
        result = [0] * len(tasks)

        time = 0
        for i in range(len(tasks)):
            time = max(time, i)

            if not available:
                time = busy[0][0]

            while busy and busy[0][0] <= time:
                _, server_id, server_weight = heapq.heappop(busy)
                heapq.heappush(available, (server_weight, server_id))

            server_weight, server_id = heapq.heappop(available)
            result[i] = server_id
            heapq.heappush(busy, (time + tasks[i], server_id, server_weight))

        return result