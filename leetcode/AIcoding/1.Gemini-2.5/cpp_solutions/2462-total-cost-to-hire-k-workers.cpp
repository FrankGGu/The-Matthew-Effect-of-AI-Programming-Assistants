#include <vector>
#include <queue>
#include <utility> // For std::pair

class Solution {
public:
    long long totalCost(std::vector<int>& costs, int k, int candidates) {
        long long total_cost = 0;

        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> pq_left;
        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> pq_right;

        int n = costs.size();
        int left_ptr = 0;
        int right_ptr = n - 1;

        for (int i = 0; i < candidates; ++i) {
            if (left_ptr <= right_ptr) {
                pq_left.push({costs[left_ptr], left_ptr});
                left_ptr++;
            } else {
                break;
            }
        }

        for (int i = 0; i < candidates; ++i) {
            if (left_ptr <= right_ptr) {
                pq_right.push({costs[right_ptr], right_ptr});
                right_ptr--;
            } else {
                break;
            }
        }

        for (int i = 0; i < k; ++i) {
            if (!pq_left.empty() && pq_right.empty()) {
                total_cost += pq_left.top().first;
                pq_left.pop();
                if (left_ptr <= right_ptr) {
                    pq_left.push({costs[left_ptr], left_ptr});
                    left_ptr++;
                }
            } else if (pq_left.empty() && !pq_right.empty()) {
                total_cost += pq_right.top().first;
                pq_right.pop();
                if (left_ptr <= right_ptr) {
                    pq_right.push({costs[right_ptr], right_ptr});
                    right_ptr--;
                }
            } else if (!pq_left.empty() && !pq_right.empty()) {
                if (pq_left.top() <= pq_right.top()) {
                    total_cost += pq_left.top().first;
                    pq_left.pop();
                    if (left_ptr <= right_ptr) {
                        pq_left.push({costs[left_ptr], left_ptr});
                        left_ptr++;
                    }
                } else {
                    total_cost += pq_right.top().first;
                    pq_right.pop();
                    if (left_ptr <= right_ptr) {
                        pq_right.push({costs[right_ptr], right_ptr});
                        right_ptr--;
                    }
                }
            }
        }

        return total_cost;
    }
};