from collections import defaultdict, deque

class TaskManager:
    def __init__(self):
        self.tasks = set()
        self.dependencies = defaultdict(set)
        self.indegree = defaultdict(int)

    def add_task(self, task_id: int) -> None:
        self.tasks.add(task_id)

    def add_dependency(self, task_id: int, dependency_id: int) -> None:
        if task_id not in self.dependencies[dependency_id]:
            self.dependencies[dependency_id].add(task_id)
            self.indegree[task_id] += 1

    def get_ready_tasks(self) -> List[int]:
        return [task for task in self.tasks if self.indegree[task] == 0]

    def complete_task(self, task_id: int) -> None:
        if task_id in self.tasks:
            self.tasks.remove(task_id)
            for dependent in self.dependencies[task_id]:
                self.indegree[dependent] -= 1
                if self.indegree[dependent] == 0:
                    self.dependencies[task_id].remove(dependent)