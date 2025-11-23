#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int maxPerformance(int n, vector<int>& speed, vector<int>& efficiency, int k) {
        vector<pair<int, int>> engineers;
        for (int i = 0; i < n; ++i) {
            engineers.push_back({efficiency[i], speed[i]});
        }

        sort(engineers.rbegin(), engineers.rend());

        priority_queue<int, vector<int>, greater<int>> pq;
        long long sum = 0;
        long long max_performance = 0;

        for (int i = 0; i < n; ++i) {
            int current_efficiency = engineers[i].first;
            int current_speed = engineers[i].second;

            sum += current_speed;
            pq.push(current_speed);

            if (pq.size() > k) {
                sum -= pq.top();
                pq.pop();
            }

            max_performance = max(max_performance, sum * current_efficiency);
        }

        return max_performance % 1000000007;
    }
};