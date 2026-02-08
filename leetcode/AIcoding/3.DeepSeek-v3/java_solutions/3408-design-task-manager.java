class TaskManager {
    private PriorityQueue<Task> taskQueue;
    private int currentTime;

    public TaskManager() {
        taskQueue = new PriorityQueue<>((a, b) -> {
            if (a.executionTime != b.executionTime) {
                return a.executionTime - b.executionTime;
            } else {
                return a.id - b.id;
            }
        });
        currentTime = 0;
    }

    public void addTask(int taskId, int executionTime, int priority) {
        Task task = new Task(taskId, executionTime, priority);
        taskQueue.offer(task);
    }

    public int executeTask() {
        if (taskQueue.isEmpty()) {
            return -1;
        }
        Task task = taskQueue.poll();
        currentTime += task.executionTime;
        return task.id;
    }

    private static class Task {
        int id;
        int executionTime;
        int priority;

        public Task(int id, int executionTime, int priority) {
            this.id = id;
            this.executionTime = executionTime;
            this.priority = priority;
        }
    }
}