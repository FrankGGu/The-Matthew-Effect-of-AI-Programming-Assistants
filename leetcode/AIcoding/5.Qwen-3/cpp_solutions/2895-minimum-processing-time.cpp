#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minProcessingTime(vector<int>& processorTime, vector<int>& tasks) {
        sort(tasks.begin(), tasks.end());
        sort(processorTime.begin(), processorTime.end());

        int maxTime = 0;
        for (int i = 0; i < tasks.size(); i++) {
            int taskIndex = i;
            int processorIndex = i / 4;
            int time = processorTime[processorIndex] + tasks[taskIndex];
            if (time > maxTime) {
                maxTime = time;
            }
        }
        return maxTime;
    }
};