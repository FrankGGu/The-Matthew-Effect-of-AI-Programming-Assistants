#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, vector<int>& bombs) {
        int n = nums.size();
        vector<int> dist(n, INT_MAX);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;

        for (int bomb : bombs) {
            dist[bomb] = 0;
            pq.push({0, bomb});
        }

        while (!pq.empty()) {
            auto [current_dist, u] = pq.top();
            pq.pop();

            if (current_dist > dist[u]) continue;

            for (int v = 0; v < n; ++v) {
                if (nums[v] > nums[u]) {
                    int new_dist = current_dist + 1;
                    if (new_dist < dist[v]) {
                        dist[v] = new_dist;
                        pq.push({new_dist, v});
                    }
                }
            }
        }

        int max_time = 0;
        for (int d : dist) {
            if (d == INT_MAX) return -1;
            max_time = max(max_time, d);
        }

        return max_time;
    }
};