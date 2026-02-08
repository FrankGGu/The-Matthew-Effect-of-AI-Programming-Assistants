#include <vector>
#include <queue>
#include <functional> // For std::greater

class Solution {
public:
    int findMinimumLogTransportationCost(std::vector<int>& logs) {
        if (logs.empty()) {
            return 0;
        }

        std::priority_queue<long long, std::vector<long long>, std::greater<long long>> pq;

        for (int log_length : logs) {
            pq.push(log_length);
        }

        long long total_cost = 0;

        while (pq.size() > 1) {
            long long first_smallest = pq.top();
            pq.pop();
            long long second_smallest = pq.top();
            pq.pop();

            long long merged_length = first_smallest + second_smallest;
            total_cost += merged_length;
            pq.push(merged_length);
        }

        return static_cast<int>(total_cost);
    }
};