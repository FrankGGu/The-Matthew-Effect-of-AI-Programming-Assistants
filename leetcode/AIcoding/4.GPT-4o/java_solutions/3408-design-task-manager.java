import java.util.*;

class TaskManager {
    private Map<Integer, Integer> taskMap;
    private int taskIdCounter;

    public TaskManager() {
        taskMap = new HashMap<>();
        taskIdCounter = 1;
    }

    public int addTask() {
        taskMap.put(taskIdCounter, 0);
        return taskIdCounter++;
    }

    public void completeTask(int taskId) {
        if (taskMap.containsKey(taskId)) {
            taskMap.put(taskId, 1);
        }
    }

    public List<Integer> getPendingTasks() {
        List<Integer> pendingTasks = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : taskMap.entrySet()) {
            if (entry.getValue() == 0) {
                pendingTasks.add(entry.getKey());
            }
        }
        return pendingTasks;
    }
}