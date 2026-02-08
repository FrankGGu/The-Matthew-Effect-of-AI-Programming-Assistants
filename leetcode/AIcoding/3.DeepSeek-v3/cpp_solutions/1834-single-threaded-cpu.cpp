class Solution {
public:
    vector<int> getOrder(vector<vector<int>>& tasks) {
        int n = tasks.size();
        vector<int> res;
        vector<array<int, 3>> sortedTasks;
        for (int i = 0; i < n; ++i) {
            sortedTasks.push_back({tasks[i][0], tasks[i][1], i});
        }
        sort(sortedTasks.begin(), sortedTasks.end());

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        int currentTime = 0;
        int i = 0;

        while (i < n || !pq.empty()) {
            if (pq.empty()) {
                currentTime = max(currentTime, sortedTasks[i][0]);
            }
            while (i < n && sortedTasks[i][0] <= currentTime) {
                pq.push({sortedTasks[i][1], sortedTasks[i][2]});
                i++;
            }
            auto [processingTime, index] = pq.top();
            pq.pop();
            currentTime += processingTime;
            res.push_back(index);
        }

        return res;
    }
};