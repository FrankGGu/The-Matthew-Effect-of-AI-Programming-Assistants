class TaskManager {
private:
    unordered_map<int, int> taskMap; // taskId -> remainingTime
    queue<int> taskQueue;
    int currentTime;

public:
    TaskManager() {
        currentTime = 0;
    }

    void addTask(int taskId, int duration) {
        taskMap[taskId] = currentTime + duration;
        taskQueue.push(taskId);
    }

    vector<int> executeTasks() {
        vector<int> executedTasks;
        currentTime++;

        while (!taskQueue.empty()) {
            int taskId = taskQueue.front();
            if (taskMap[taskId] <= currentTime) {
                executedTasks.push_back(taskId);
                taskMap.erase(taskId);
                taskQueue.pop();
            } else {
                break;
            }
        }

        return executedTasks;
    }
};