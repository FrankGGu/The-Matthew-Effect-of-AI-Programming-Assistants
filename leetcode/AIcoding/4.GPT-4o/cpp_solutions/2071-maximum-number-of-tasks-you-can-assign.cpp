class Solution {
public:
    int maxTasksAssigned(vector<int>& tasks, int maxTime) {
        sort(tasks.begin(), tasks.end());
        int count = 0, totalTime = 0;

        for (int time : tasks) {
            if (totalTime + time <= maxTime) {
                totalTime += time;
                count++;
            } else {
                break;
            }
        }

        return count;
    }
};