#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    long long totalCost(vector<int>& costs, int k, int candidates) {
        int n = costs.size();
        priority_queue<int, vector<int>, greater<int>> pq1, pq2;

        for (int i = 0; i < candidates && i < n; ++i) {
            pq1.push(costs[i]);
        }

        for (int i = max(candidates, n - candidates); i < n; ++i) {
            pq2.push(costs[i]);
        }

        long long total_cost = 0;
        int next_left = candidates;
        int next_right = n - candidates - 1;

        for (int i = 0; i < k; ++i) {
            if (pq1.empty() && pq2.empty()) break;
            if (pq2.empty() || (!pq1.empty() && pq1.top() <= pq2.top())) {
                total_cost += pq1.top();
                pq1.pop();
                if (next_left <= next_right) {
                    pq1.push(costs[next_left]);
                    next_left++;
                }
            } else {
                total_cost += pq2.top();
                pq2.pop();
                if (next_left <= next_right) {
                    pq2.push(costs[next_right]);
                    next_right--;
                }
            }
        }

        return total_cost;
    }
};