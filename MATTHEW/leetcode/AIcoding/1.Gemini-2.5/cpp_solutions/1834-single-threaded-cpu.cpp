#include <vector>
#include <queue>
#include <algorithm>
#include <utility> // For std::pair

struct Task {
    int enqueueTime;
    int processingTime;
    int originalIndex;
};

class Solution {
public:
    std::vector<int> getOrder(std::vector<std::vector<int>>& tasks) {
        int n = tasks.size();
        std::vector<Task> indexedTasks(n);
        for (int i = 0; i < n; ++i) {
            indexedTasks[i] = {tasks[i][0], tasks[i][1], i};
        }

        std::sort(indexedTasks.begin(), indexedTasks.end(), [](const Task& a, const Task& b) {
            return a.enqueueTime < b.enqueueTime;
        });

        std::vector<int> result;
        // Min-priority queue to store available tasks, ordered by processing time then original index
        // Pair: {processingTime, originalIndex}
        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> readyTasks;

        long long currentTime = 0; 
        int taskPointer = 0; 

        while (result.size() < n) {
            while (taskPointer < n && indexedTasks[taskPointer].enqueueTime <= currentTime) {
                readyTasks.push({indexedTasks[taskPointer].processingTime, indexedTasks[taskPointer].originalIndex});
                taskPointer++;
            }

            if (!readyTasks.empty()) {
                std::pair<int, int> currentTask = readyTasks.top();
                readyTasks.pop();

                int processingTime = currentTask.first;
                int originalIndex = currentTask.second;

                result.push_back(originalIndex);
                currentTime += processingTime;
            } else {
                if (taskPointer < n) {
                    currentTime = indexedTasks[taskPointer].enqueueTime;
                }
            }
        }

        return result;
    }
};