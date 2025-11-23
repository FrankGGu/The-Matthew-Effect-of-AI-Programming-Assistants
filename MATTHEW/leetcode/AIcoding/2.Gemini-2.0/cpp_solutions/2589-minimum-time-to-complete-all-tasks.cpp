#include <vector>
#include <algorithm>

using namespace std;

struct Task {
    int start;
    int end;
    int duration;
};

int minAvailableTime(int n, vector<vector<int>>& tasks) {
    vector<Task> taskList;
    for (auto& task : tasks) {
        taskList.push_back({task[0], task[1], task[2]});
    }

    sort(taskList.begin(), taskList.end(), [](const Task& a, const Task& b) {
        return a.end < b.end;
    });

    vector<bool> schedule(n + 1, false);
    int count = 0;

    for (auto& task : taskList) {
        int start = task.start;
        int end = task.end;
        int duration = task.duration;

        for (int i = start; i <= end; ++i) {
            if (schedule[i]) {
                duration--;
            }
        }

        if (duration > 0) {
            for (int i = end; i >= start && duration > 0; --i) {
                if (!schedule[i]) {
                    schedule[i] = true;
                    duration--;
                    count++;
                }
            }
        }
    }

    return count;
}