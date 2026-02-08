class Solution {
public:
    int findCrossingTime(int n, int k, vector<vector<int>>& time) {
        priority_queue<vector<int>, vector<vector<int>>, greater<vector<int>>> minHeap;
        for (int i = 0; i < k; ++i) {
            minHeap.push({time[i][0], i});
        }

        int currentTime = 0;
        vector<int> worker(2, 0);

        for (int i = 0; i < n; ++i) {
            auto [finishTime, index] = minHeap.top();
            minHeap.pop();
            currentTime = max(currentTime, finishTime) + time[index][1];
            worker[0] = finishTime + time[index][1];
            worker[1] = index;
            minHeap.push(worker);
        }

        while (!minHeap.empty()) {
            auto [finishTime, index] = minHeap.top();
            minHeap.pop();
            currentTime = max(currentTime, finishTime);
        }

        return currentTime;
    }
};