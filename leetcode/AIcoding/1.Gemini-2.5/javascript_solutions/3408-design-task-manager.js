class TaskManager {
    constructor() {
        this.tasks = new Map();
    }

    addTask(taskId, deadline, priority) {
        this.tasks.set(taskId, {
            deadline: deadline,
            priority: priority,
            completed: false
        });
    }

    markTaskAsCompleted(taskId) {
        if (this.tasks.has(taskId)) {
            this.tasks.get(taskId).completed = true;
            return true;
        }
        return false;
    }

    getPendingTasks(currentTime) {
        const pendingTaskIds = [];
        for (const [taskId, task] of this.tasks.entries()) {
            if (!task.completed && task.deadline >= currentTime) {
                pendingTaskIds.push(taskId);
            }
        }
        return pendingTaskIds;
    }

    getTopPriorityTask(currentTime) {
        let topPriorityTaskId = null;
        let maxPriority = -1; // Assuming priority is non-negative
        let earliestDeadlineForMaxPriority = Infinity; // Tie-breaker for priority

        for (const [taskId, task] of this.tasks.entries()) {
            if (!task.completed && task.deadline >= currentTime) {
                if (task.priority > maxPriority) {
                    maxPriority = task.priority;
                    topPriorityTaskId = taskId;
                    earliestDeadlineForMaxPriority = task.deadline;
                } else if (task.priority === maxPriority) {
                    // Tie-breaker: if priorities are equal, pick the one with the earliest deadline
                    if (task.deadline < earliestDeadlineForMaxPriority) {
                        topPriorityTaskId = taskId;
                        earliestDeadlineForMaxPriority = task.deadline;
                    } else if (task.deadline === earliestDeadlineForMaxPriority) {
                        // Further tie-breaker: if deadlines are also equal, pick the one with the smaller taskId
                        if (topPriorityTaskId === null || taskId < topPriorityTaskId) {
                             topPriorityTaskId = taskId;
                        }
                    }
                }
            }
        }
        return topPriorityTaskId;
    }
}