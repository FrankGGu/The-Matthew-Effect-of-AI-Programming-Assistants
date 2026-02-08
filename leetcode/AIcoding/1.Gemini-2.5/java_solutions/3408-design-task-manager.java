import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;

class TaskManager {

    public static class Task {
        private int id;
        private String description;
        private long dueDate;
        private Status status;

        public enum Status {
            PENDING,
            IN_PROGRESS,
            COMPLETED
        }

        public Task(int id, String description, long dueDate) {
            this.id = id;
            this.description = description;
            this.dueDate = dueDate;
            this.status = Status.PENDING;
        }

        public int getId() { return id; }
        public String getDescription() { return description; }
        public long getDueDate() { return dueDate; }
        public Status getStatus() { return status; }

        public void setStatus(Status status) { this.status = status; }
        public void setDescription(String description) { this.description = description; }
        public void setDueDate(long dueDate) { this.dueDate = dueDate; }
    }

    private Map<Integer, Task> tasks;

    public TaskManager() {
        tasks = new HashMap<>();
    }

    public boolean addTask(int id, String description, long dueDate) {
        if (tasks.containsKey(id)) {
            return false;
        }
        tasks.put(id, new Task(id, description, dueDate));
        return true;
    }

    public Task getTask(int id) {
        return tasks.get(id);
    }

    public boolean updateTaskStatus(int id, Task.Status newStatus) {
        Task task = tasks.get(id);
        if (task == null) {
            return false;
        }
        task.setStatus(newStatus);
        return true;
    }

    public boolean updateTaskDescription(int id, String newDescription) {
        Task task = tasks.get(id);
        if (task == null) {
            return false;
        }
        task.setDescription(newDescription);
        return true;
    }

    public boolean updateTaskDueDate(int id, long newDueDate) {
        Task task = tasks.get(id);
        if (task == null) {
            return false;
        }
        task.setDueDate(newDueDate);
        return true;
    }

    public boolean deleteTask(int id) {
        return tasks.remove(id) != null;
    }

    public List<Task> getTasksByStatus(Task.Status status) {
        return tasks.values().stream()
                     .filter(task -> task.getStatus() == status)
                     .collect(Collectors.toList());
    }

    public List<Task> getTasksDueBefore(long thresholdDate) {
        return tasks.values().stream()
                     .filter(task -> task.getDueDate() < thresholdDate)
                     .collect(Collectors.toList());
    }

    public List<Task> getAllTasks() {
        return new ArrayList<>(tasks.values());
    }
}