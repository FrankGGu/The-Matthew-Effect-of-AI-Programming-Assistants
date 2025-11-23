#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    double minCostToHireWorkers(vector<int>& quality, vector<int>& wage, int K) {
        int n = quality.size();
        vector<pair<double, int>> workers(n);

        for (int i = 0; i < n; ++i) {
            workers[i] = {static_cast<double>(wage[i]) / quality[i], quality[i]};
        }

        sort(workers.begin(), workers.end());

        priority_queue<int> maxHeap;
        double totalQuality = 0.0;
        double minCost = DBL_MAX;

        for (int i = 0; i < n; ++i) {
            totalQuality += workers[i].second;
            maxHeap.push(workers[i].second);

            if (maxHeap.size() > K) {
                totalQuality -= maxHeap.top();
                maxHeap.pop();
            }

            if (maxHeap.size() == K) {
                minCost = min(minCost, totalQuality * workers[i].first);
            }
        }

        return minCost;
    }
};