import heapq

class Solution:
    def assignTasks(self, servers: List[int], tasks: List[int]) -> List[int]:
        free_servers = [(w, i) for i, w in enumerate(servers)]
        heapq.heapify(free_servers)
        busy_servers = []
        result = []
        time = 0

        for i, task in enumerate(tasks):
            time = max(time, i)
            while busy_servers and busy_servers[0][0] <= time:
                _, idx = heapq.heappop(busy_servers)
                heapq.heappush(free_servers, (servers[idx], idx))

            if free_servers:
                weight, idx = heapq.heappop(free_servers)
                result.append(idx)
                heapq.heappush(busy_servers, (time + task, idx))
            else:
                finish_time, idx = heapq.heappop(busy_servers)
                time = finish_time
                result.append(idx)
                heapq.heappush(busy_servers, (time + task, idx))

        return result