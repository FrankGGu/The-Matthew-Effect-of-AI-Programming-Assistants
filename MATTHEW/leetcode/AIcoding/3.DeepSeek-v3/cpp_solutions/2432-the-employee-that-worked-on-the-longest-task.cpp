class Solution {
public:
    int hardestWorker(int n, vector<vector<int>>& logs) {
        int max_time = logs[0][1];
        int id = logs[0][0];

        for (int i = 1; i < logs.size(); ++i) {
            int current_time = logs[i][1] - logs[i-1][1];
            if (current_time > max_time) {
                max_time = current_time;
                id = logs[i][0];
            } else if (current_time == max_time) {
                if (logs[i][0] < id) {
                    id = logs[i][0];
                }
            }
        }

        return id;
    }
};