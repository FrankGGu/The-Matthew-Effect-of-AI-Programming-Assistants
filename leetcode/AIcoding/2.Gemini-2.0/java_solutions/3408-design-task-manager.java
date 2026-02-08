import java.util.*;

class TaskManager {

    private PriorityQueue<Task> pq;
    private Map<Integer, Task> taskMap;
    private int currentTime;

    public TaskManager() {
        pq = new PriorityQueue<>((a, b) -> {
            if (a.enqueueTime != b.enqueueTime) {
                return a.enqueueTime - b.enqueueTime;
            }
            return a.index - b.index;
        });
        taskMap = new HashMap<>();
        currentTime = 0;
    }

    public void addTask(int index, int enqueueTime, int processingTime) {
        Task task = new Task(index, enqueueTime, processingTime);
        pq.offer(task);
        taskMap.put(index, task);
    }

    public int processNextTask() {
        while (!pq.isEmpty() && pq.peek().enqueueTime > currentTime) {
            currentTime++;
        }

        if (pq.isEmpty()) {
            return -1;
        }

        Task task = pq.poll();
        taskMap.remove(task.index);
        currentTime += task.processingTime;
        return task.index;
    }

    public int getCurrentTime() {
        return currentTime;
    }

    private static class Task {
        int index;
        int enqueueTime;
        int processingTime;

        public Task(int index, int enqueueTime, int processingTime) {
            this.index = index;
            this.enqueueTime = enqueueTime;
            this.processingTime = processingTime;
        }
    }
}