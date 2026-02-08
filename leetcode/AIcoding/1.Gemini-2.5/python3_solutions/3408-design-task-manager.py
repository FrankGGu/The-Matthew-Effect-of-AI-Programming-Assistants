import heapq

class TaskManager:

    def __init__(self):
        # Stores taskId -> (priority, timestamp, description)
        # This dictionary serves as the canonical source of truth for task details.
        # The timestamp is used for tie-breaking when priorities are equal and
        # to identify stale entries in the priority queue after updates or completions.
        self.tasks = {} 

        # Min-heap stores (-priority, timestamp, taskId) tuples.
        # - Negative priority ensures that tasks with higher priority (larger integer value)
        #   are popped first from the min-heap.
        # - Timestamp ensures that among tasks with the same priority, the one added
        #   or last updated earliest (smaller timestamp) is popped first.
        self.priority_queue = []

        # A monotonically increasing counter to assign unique timestamps to tasks
        # when they are added or updated.
        self.time_counter = 0 

    def addTask(self, taskId: int, priority: int, description: str) -> None:
        self.time_counter += 1

        # Update the task's current state in the dictionary.
        # This ensures that `self.tasks` always holds the most recent information.
        self.tasks[taskId] = (priority, self.time_counter, description)

        # Push a new entry to the priority queue.
        # If `taskId` already existed and was updated, its old entry in the heap
        # will become "stale" and will be ignored by `getNextTask` due to the
        # timestamp and priority check.
        heapq.heappush(self.priority_queue, (-priority, self.time_counter, taskId))

    def completeTask(self, taskId: int) -> None:
        # Remove the task from the canonical dictionary.
        # Any corresponding entries in the priority queue will effectively become "stale"
        # and will be ignored by `getNextTask` because `taskId` will no longer be in `self.tasks`.
        if taskId in self.tasks:
            del self.tasks[taskId]

    def getNextTask(self) -> int:
        # Continuously pop from the priority queue until a valid, non-stale task is found.
        while self.priority_queue:
            neg_priority, timestamp, taskId = heapq.heappop(self.priority_queue)

            # Check if the task still exists in our canonical dictionary.
            if taskId in self.tasks:
                current_priority, current_timestamp, _ = self.tasks[taskId]

                # Further check if the heap entry corresponds to the *current* state of the task.
                # This handles cases where a task was updated (new priority and/or timestamp)
                # while an older entry for it was still in the heap.
                if current_priority == -neg_priority and current_timestamp == timestamp:
                    return taskId # Found a valid, highest priority (and earliest-added-among-ties) task

            # If we reach here, the popped task is either completed or outdated (its details
            # in `self.tasks` no longer match this heap entry).
            # Continue to the next item in the heap.

        return -1 # No valid tasks left in the manager