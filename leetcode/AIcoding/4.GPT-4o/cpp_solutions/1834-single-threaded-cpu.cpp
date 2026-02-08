class Solution {
public:
    vector<int> getOrder(vector<vector<int>>& tasks) {
        int n = tasks.size();
        vector<pair<long long, int>> taskList(n);
        for (int i = 0; i < n; i++) {
            taskList[i] = {tasks[i][0], i};
        }
        sort(taskList.begin(), taskList.end());

        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
        vector<int> result;
        long long currentTime = 0;
        int index = 0;

        while (index < n || !pq.empty()) {
            if (pq.empty()) {
                currentTime = max(currentTime, taskList[index].first);
            }
            while (index < n && taskList[index].first <= currentTime) {
                pq.push({tasks[taskList[index].second][1], taskList[index].second});
                index++;
            }
            auto [duration, taskIndex] = pq.top();
            pq.pop();
            currentTime += duration;
            result.push_back(taskIndex);
        }

        return result;
    }
};