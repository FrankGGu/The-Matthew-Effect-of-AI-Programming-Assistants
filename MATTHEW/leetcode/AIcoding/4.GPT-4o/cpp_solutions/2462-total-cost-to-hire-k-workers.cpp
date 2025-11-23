#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long totalCost(vector<int>& costs, int k, int candidates) {
        int n = costs.size();
        priority_queue<int, vector<int>, greater<int>> pq;
        long long total = 0;

        for (int i = 0; i < min(candidates, n); ++i) {
            pq.push(costs[i]);
        }
        for (int i = max(0, n - candidates); i < n; ++i) {
            if (i < n - candidates) {
                pq.push(costs[i]);
            }
        }

        for (int i = 0; i < k; ++i) {
            if (pq.empty()) break;
            total += pq.top();
            pq.pop();
            if (i < n) {
                if (i < candidates) {
                    pq.push(costs[i + candidates]);
                }
                if (n - 1 - i >= candidates) {
                    pq.push(costs[n - 1 - i]);
                }
            }
        }

        return total;
    }
};