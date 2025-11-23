#include <vector>
#include <algorithm>
#include <queue>
#include <utility> // For std::pair

class Solution {
public:
    long long maxPerformance(int n, std::vector<int>& speeds, std::vector<int>& efficiencies, int k) {
        std::vector<std::pair<int, int>> engineers;
        for (int i = 0; i < n; ++i) {
            engineers.push_back({efficiencies[i], speeds[i]});
        }

        std::sort(engineers.begin(), engineers.end(), [](const std::pair<int, int>& a, const std::pair<int, int>& b) {
            return a.first > b.first;
        });

        std::priority_queue<int, std::vector<int>, std::greater<int>> min_pq;

        long long current_speed_sum = 0;
        long long max_performance = 0;

        for (const auto& engineer : engineers) {
            int efficiency = engineer.first;
            int speed = engineer.second;

            current_speed_sum += speed;
            min_pq.push(speed);

            if (min_pq.size() > k) {
                current_speed_sum -= min_pq.top();
                min_pq.pop();
            }

            max_performance = std::max(max_performance, current_speed_sum * efficiency);
        }

        return max_performance;
    }
};