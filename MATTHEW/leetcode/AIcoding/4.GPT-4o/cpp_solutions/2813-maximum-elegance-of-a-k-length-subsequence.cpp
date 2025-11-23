class Solution {
public:
    long long maxElegance(vector<vector<int>>& items, int k) {
        sort(items.begin(), items.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] > b[1];
        });

        long long totalElegance = 0;
        long long maxElegance = 0;
        priority_queue<int, vector<int>, greater<int>> minHeap;
        int countUnique = 0;

        for (int i = 0; i < items.size(); ++i) {
            if (minHeap.size() < k) {
                totalElegance += items[i][1];
                minHeap.push(items[i][0]);
                if (minHeap.size() == 1) countUnique++;
            } else if (minHeap.size() == k) {
                if (minHeap.top() < items[i][0]) {
                    totalElegance += items[i][1] - items[minHeap.top()][1];
                    minHeap.pop();
                    minHeap.push(items[i][0]);
                }
            }
            if (minHeap.size() == k) {
                maxElegance = max(maxElegance, totalElegance + (long long)countUnique * countUnique);
            }
            countUnique += (minHeap.size() < k || items[i][0] != minHeap.top());
        }

        return maxElegance;
    }
};