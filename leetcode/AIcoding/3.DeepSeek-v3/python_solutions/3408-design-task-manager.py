import heapq

class TaskManager:

    def __init__(self):
        self.heap = []
        self.task_id = 1
        self.paused = set()

    def addTask(self, duration: int) -> int:
        task_id = self.task_id
        heapq.heappush(self.heap, (duration, task_id))
        self.task_id += 1
        return task_id

    def poll(self) -> int:
        while self.heap:
            duration, task_id = heapq.heappop(self.heap)
            if task_id not in self.paused:
                return task_id
            else:
                self.paused.remove(task_id)
        return -1

    def pause(self, task_id: int) -> bool:
        if task_id < 1 or task_id >= self.task_id:
            return False
        self.paused.add(task_id)
        return True

    def unpause(self, task_id: int) -> bool:
        if task_id not in self.paused:
            return False
        self.paused.remove(task_id)
        return True

    def cancel(self, task_id: int) -> bool:
        if task_id < 1 or task_id >= self.task_id:
            return False
        if task_id in self.paused:
            self.paused.remove(task_id)
            return True
        for i in range(len(self.heap)):
            if self.heap[i][1] == task_id:
                self.heap.pop(i)
                heapq.heapify(self.heap)
                return True
        return False