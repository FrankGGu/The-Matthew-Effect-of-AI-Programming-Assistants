#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

struct Task {
    int id;
    int enqueueTime;
    int processingTime;
};

struct CompareTasks {
    bool operator()(const Task& a, const Task& b) {
        if (a.processingTime != b.processingTime) {
            return a.processingTime > b.processingTime;
        }
        return a.id > b.id;
    }
};

class Solution {
public:
    vector<int> getOrder(vector<vector<int>>& tasks) {
        int n = tasks.size();
        vector<Task> allTasks(n);
        for (int i = 0; i < n; ++i) {
            allTasks[i] = {i, tasks[i][0], tasks[i][1]};
        }

        sort(allTasks.begin(), allTasks.end(), [](const Task& a, const Task& b) {
            return a.enqueueTime < b.enqueueTime;
        });

        priority_queue<Task, vector<Task>, CompareTasks> pq;
        vector<int> result;
        long long currentTime = 0;
        int taskIndex = 0;

        while (result.size() < n) {
            while (taskIndex < n && allTasks[taskIndex].enqueueTime <= currentTime) {
                pq.push(allTasks[taskIndex]);
                taskIndex++;
            }

            if (pq.empty()) {
                if (taskIndex < n) {
                    currentTime = allTasks[taskIndex].enqueueTime;
                } else {
                    break;
                }
                continue;
            }

            Task currentTask = pq.top();
            pq.pop();
            result.push_back(currentTask.id);
            currentTime += currentTask.processingTime;
        }

        return result;
    }
};