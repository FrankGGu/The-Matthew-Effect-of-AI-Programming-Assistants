class Solution {
public:
    int maxEvents(vector<vector<int>>& events) {
        sort(events.begin(), events.end());
        priority_queue<int, vector<int>, greater<int>> minHeap;
        int res = 0, i = 0, n = events.size();
        for (int d = 1; d <= 100000; ++d) {
            while (!minHeap.empty() && minHeap.top() < d) {
                minHeap.pop();
            }
            while (i < n && events[i][0] == d) {
                minHeap.push(events[i][1]);
                ++i;
            }
            if (!minHeap.empty()) {
                minHeap.pop();
                ++res;
            }
        }
        return res;
    }
};