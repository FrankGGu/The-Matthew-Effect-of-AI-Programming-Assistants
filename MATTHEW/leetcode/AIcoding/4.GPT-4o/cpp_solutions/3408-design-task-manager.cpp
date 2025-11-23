class TaskManager {
public:
    unordered_map<int, priority_queue<int, vector<int>, greater<int>>> taskQueues;
    unordered_map<int, int> taskToWorker;

    TaskManager() {}

    void addTask(int workerId, int taskId) {
        taskQueues[workerId].push(taskId);
    }

    int getTask(int workerId) {
        if (taskQueues[workerId].empty()) return -1;
        int taskId = taskQueues[workerId].top();
        taskQueues[workerId].pop();
        taskToWorker[taskId] = workerId;
        return taskId;
    }

    void completeTask(int taskId) {
        taskToWorker.erase(taskId);
    }

    int getWorkerId(int taskId) {
        return taskToWorker.count(taskId) ? taskToWorker[taskId] : -1;
    }
};