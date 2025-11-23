public class Solution {

import java.util.*;

public class TaskManager {
    private int taskId;
    private PriorityQueue<Task> pendingTasks;
    private Map<Integer, Task> taskMap;

    public TaskManager() {
        this.taskId = 0;
        this.pendingTasks = new PriorityQueue<>((a, b) -> {
            if (a.priority != b.priority) {
                return b.priority - a.priority;
            }
            return a.timestamp - b.timestamp;
        });
        this.taskMap = new HashMap<>();
    }

    public int addTask(String taskName, int priority) {
        taskId++;
        Task task = new Task(taskId, taskName, priority);
        pendingTasks.add(task);
        taskMap.put(taskId, task);
        return taskId;
    }

    public boolean cancelTask(int taskId) {
        Task task = taskMap.get(taskId);
        if (task == null) {
            return false;
        }
        taskMap.remove(taskId);
        pendingTasks.remove(task);
        return true;
    }

    public String getHighestPriorityTask() {
        if (pendingTasks.isEmpty()) {
            return "";
        }
        Task task = pendingTasks.peek();
        return task.taskName;
    }

    private static class Task {
        int id;
        String taskName;
        int priority;
        int timestamp;

        public Task(int id, String taskName, int priority) {
            this.id = id;
            this.taskName = taskName;
            this.priority = priority;
            this.timestamp = System.currentTimeMillis();
        }
    }
}
}