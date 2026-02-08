class Solution {
public:
    int maxPerformance(int n, vector<int>& speed, vector<int>& efficiency, int k) {
        vector<pair<int, int>> engineers(n);
        for (int i = 0; i < n; ++i) {
            engineers[i] = {efficiency[i], speed[i]};
        }

        sort(engineers.rbegin(), engineers.rend());

        priority_queue<int, vector<int>, greater<int>> minHeap;
        long long totalSpeed = 0, maxPerformance = 0, mod = 1e9 + 7;

        for (const auto& [eff, spd] : engineers) {
            if (minHeap.size() == k) {
                totalSpeed -= minHeap.top();
                minHeap.pop();
            }
            minHeap.push(spd);
            totalSpeed += spd;
            maxPerformance = max(maxPerformance, totalSpeed * eff);
        }

        return maxPerformance % mod;
    }
};