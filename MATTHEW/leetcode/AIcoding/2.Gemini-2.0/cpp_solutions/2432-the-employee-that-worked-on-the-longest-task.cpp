#include <vector>

using namespace std;

class Solution {
public:
    int hardestWorker(int n, vector<vector<int>>& logs) {
        int max_time = logs[0][1];
        int hardest_worker = logs[0][0];

        for (int i = 1; i < logs.size(); ++i) {
            int time_taken = logs[i][1] - logs[i - 1][1];
            if (i == 0) {
                time_taken = logs[i][1];
            } else {
                time_taken = logs[i][1] - logs[i-1][1];
            }

            if (time_taken > max_time) {
                max_time = time_taken;
                hardest_worker = logs[i][0];
            } else if (time_taken == max_time) {
                hardest_worker = min(hardest_worker, logs[i][0]);
            }
        }

        return hardest_worker;
    }
};