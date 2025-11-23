#include <queue>
#include <unordered_set>
#include <utility> // Required for std::pair

class TaskManager {
private:
    // Stores pairs of (priority, taskId).
    // std::priority_queue is a max-heap by default for pairs,
    // meaning the task with the highest priority will be at the top.
    std::priority_queue<std::pair<int, int>> tasks;

    // Stores the IDs of tasks that have been marked as completed.
    // This allows lazy removal from the priority queue.
    std::unordered_set<int> completedTasks;

public:
    TaskManager() {
        // Constructor: No explicit initialization needed for member variables.
        // They are default-constructed.
    }

    void addTask(int taskId, int priority) {
        // Add a new task to the priority queue.
        // If a task with the same ID was previously completed, this effectively
        // re-adds it or adds a new instance. The problem typically implies
        // unique IDs for active tasks, or that new additions are distinct.
        tasks.push({priority, taskId});
    }

    int getHighestPriorityTask() {
        // Lazily remove completed tasks from the top of the priority queue.
        // We keep popping until we find an active task or the queue becomes empty.
        while (!tasks.empty() && completedTasks.count(tasks.top().second)) {
            tasks.pop();
        }

        // If the priority queue is empty after cleanup, there are no active tasks.
        if (tasks.empty()) {
            return -1; // Return -1 as a common indicator for "no task found".
        } else {
            // Return the ID of the highest priority active task.
            return tasks.top().second;
        }
    }

    void markTaskCompleted(int taskId) {
        // Add the task ID to the set of completed tasks.
        // This task will be ignored by getHighestPriorityTask() when encountered.
        completedTasks.insert(taskId);
    }
};