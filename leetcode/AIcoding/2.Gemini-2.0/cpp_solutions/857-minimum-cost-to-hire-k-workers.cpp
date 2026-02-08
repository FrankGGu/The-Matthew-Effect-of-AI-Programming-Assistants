#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    double mincostToHireWorkers(vector<int>& quality, vector<int>& wage, int k) {
        int n = quality.size();
        vector<pair<double, int>> workers;
        for (int i = 0; i < n; ++i) {
            workers.push_back({(double)wage[i] / quality[i], quality[i]});
        }
        sort(workers.begin(), workers.end());

        priority_queue<int> pq;
        double total_quality = 0;
        double min_cost = 1e18;

        for (auto& worker : workers) {
            double ratio = worker.first;
            int q = worker.second;

            pq.push(q);
            total_quality += q;

            if (pq.size() > k) {
                total_quality -= pq.top();
                pq.pop();
            }

            if (pq.size() == k) {
                min_cost = min(min_cost, ratio * total_quality);
            }
        }

        return min_cost;
    }
};