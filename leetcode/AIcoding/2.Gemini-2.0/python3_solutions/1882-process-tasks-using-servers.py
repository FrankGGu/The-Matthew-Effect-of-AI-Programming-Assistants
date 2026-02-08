import heapq

class Solution:
    def assignTasks(self, servers: list[int], tasks: list[int]) -> list[int]:
        available = [(servers[i], i) for i in range(len(servers))]
        heapq.heapify(available)
        busy = []
        time = 0
        result = []
        task_idx = 0

        while task_idx < len(tasks):
            while busy and busy[0][0] <= time:
                _, idx = heapq.heappop(busy)
                heapq.heappush(available, (servers[idx], idx))

            if not available:
                time = busy[0][0]
                continue

            while task_idx <= time and task_idx < len(tasks) and available:
                weight, idx = heapq.heappop(available)
                result.append(idx)
                heapq.heappush(busy, (time + tasks[task_idx], idx))
                task_idx += 1

            if not available:
                time = busy[0][0]
            else:
                time = max(time + 1, task_idx)

        return result