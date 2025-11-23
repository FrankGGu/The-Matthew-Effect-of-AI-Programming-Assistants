class Solution {
public:
    int findMinimumTime(vector<vector<int>>& tasks) {
        sort(tasks.begin(), tasks.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        vector<bool> time(2001, false);
        int res = 0;

        for (auto& task : tasks) {
            int start = task[0], end = task[1], duration = task[2];
            int already = 0;
            for (int i = start; i <= end; ++i) {
                if (time[i]) already++;
            }
            if (already >= duration) continue;
            int needed = duration - already;
            for (int i = end; i >= start && needed > 0; --i) {
                if (!time[i]) {
                    time[i] = true;
                    needed--;
                    res++;
                }
            }
        }

        return res;
    }
};