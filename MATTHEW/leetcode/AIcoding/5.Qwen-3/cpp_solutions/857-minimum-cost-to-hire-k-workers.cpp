#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    double minCostToHireKWorkers(vector<int>& quality, vector<int>& wage, int k) {
        int n = quality.size();
        vector<pair<int, int>> workers(n);

        for (int i = 0; i < n; ++i) {
            workers[i] = {wage[i], quality[i]};
        }

        sort(workers.begin(), workers.end());

        priority_queue<int> maxHeap;
        double totalQuality = 0.0;
        double minCost = 0.0;

        for (int i = 0; i < n; ++i) {
            int currentWage = workers[i].first;
            int currentQuality = workers[i].second;

            totalQuality += currentQuality;
            maxHeap.push(currentQuality);

            if (maxHeap.size() > k) {
                totalQuality -= maxHeap.top();
                maxHeap.pop();
            }

            if (maxHeap.size() == k) {
                double cost = (double)currentWage / currentQuality * totalQuality;
                if (i == 0) {
                    minCost = cost;
                } else {
                    minCost = min(minCost, cost);
                }
            }
        }

        return minCost;
    }
};