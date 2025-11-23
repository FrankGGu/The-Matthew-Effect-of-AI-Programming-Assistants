#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long taskSchedulerII(vector<int>& tasks, int space) {
        unordered_map<int, long long> lastDay;
        long long currentDay = 0;

        for (int task : tasks) {
            if (lastDay.find(task) != lastDay.end() && currentDay < lastDay[task] + space + 1) {
                currentDay = lastDay[task] + space + 1;
            }
            lastDay[task] = currentDay;
            currentDay++;
        }

        return currentDay;
    }
};