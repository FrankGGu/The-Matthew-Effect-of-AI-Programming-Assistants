class TaskManager:
    def __init__(self):
        self.tasks = []
        self.completed = set()

    def addTask(self, task: str) -> int:
        self.tasks.append(task)
        return len(self.tasks) - 1

    def completeTask(self, taskId: int) -> None:
        if 0 <= taskId < len(self.tasks):
            self.completed.add(taskId)

    def getUncompletedTasks(self) -> List[str]:
        return [task for i, task in enumerate(self.tasks) if i not in self.completed]