#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPerformance(int n, vector<int>& speed, vector<int>& efficiency, int k) {
        vector<pair<int, int>> engineers;
        for (int i = 0; i < n; ++i) {
            engineers.emplace_back(efficiency[i], speed[i]);
        }

        sort(engineers.begin(), engineers.end(), greater<pair<int, int>>());

        priority_queue<int, vector<int>, greater<int>> minHeap;
        int totalSpeed = 0;
        long long maxPerformance = 0;

        for (auto& [eff, spd] : engineers) {
            if (minHeap.size() == k) {
                totalSpeed -= minHeap.top();
                minHeap.pop();
            }
            minHeap.push(spd);
            totalSpeed += spd;
            maxPerformance = max(maxPerformance, static_cast<long long>(totalSpeed) * eff);
        }

        return static_cast<int>(maxPerformance);
    }
};