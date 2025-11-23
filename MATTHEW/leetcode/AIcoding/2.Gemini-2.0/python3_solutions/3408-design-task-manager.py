import heapq

class TaskManager:

    def __init__(self, n: int):
        self.n = n
        self.available = list(range(1, n + 1))
        self.running = {}
        self.heap = []

    def allocate(self, task_id: int) -> int:
        if self.available:
            server_id = self.available.pop(0)
            self.running[task_id] = server_id
            return server_id
        else:
            end_time, server_id = heapq.heappop(self.heap)
            self.available.append(server_id)
            self.available.sort()
            server_id = self.available.pop(0)
            self.running[task_id] = server_id
            return server_id

    def deallocate(self, task_id: int, end_time: int) -> None:
        server_id = self.running.pop(task_id)
        heapq.heappush(self.heap, (end_time, server_id))