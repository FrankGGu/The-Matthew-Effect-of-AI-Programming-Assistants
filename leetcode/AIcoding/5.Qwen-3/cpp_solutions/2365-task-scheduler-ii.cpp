#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    long long taskSchedulerII(vector<int>& tasks, int space) {
        unordered_map<int, long long> lastTime;
        long long currentTime = 0;

        for (int task : tasks) {
            if (lastTime.find(task) != lastTime.end()) {
                currentTime = max(currentTime + 1, lastTime[task] + 1);
            } else {
                currentTime++;
            }
            lastTime[task] = currentTime;
        }

        return currentTime;
    }
};