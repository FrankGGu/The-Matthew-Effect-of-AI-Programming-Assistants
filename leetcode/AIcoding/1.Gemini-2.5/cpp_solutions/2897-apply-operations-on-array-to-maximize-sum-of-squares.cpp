#include <vector>
#include <queue>
#include <cmath> // For ceil, though integer arithmetic is used

class Solution {
public:
    long long maxSumOfSquares(std::vector<int>& nums, int k) {
        // Use a min-priority queue to efficiently get the smallest element.
        // The problem states that to maximize the sum of squares, we should
        // minimize the reduction caused by each operation.
        // The reduction for an element x is x*x - ceil(x/3.0)*ceil(x/3.0).
        // This reduction function is monotonically increasing for x >= 1.
        // Therefore, to minimize the reduction, we should always apply the
        // operation to the smallest element currently in the array (that is > 1).
        // A min-priority queue allows us to repeatedly extract the smallest element.

        std::priority_queue<long long, std::vector<long long>, std::greater<long long>> pq;

        for (int num : nums) {
            pq.push(num);
        }

        for (int i = 0; i < k; ++i) {
            long long current_val = pq.top();
            pq.pop();

            // Calculate ceil(current_val / 3.0) using integer arithmetic.
            // For positive integers a, b, ceil(a/b) can be computed as (a + b - 1) / b.
            // Here, b = 3.
            long long new_val = (current_val + 2) / 3;

            pq.push(new_val);
        }

        long long total_sum_of_squares = 0;
        while (!pq.empty()) {
            long long val = pq.top();
            pq.pop();
            total_sum_of_squares += val * val;
        }

        return total_sum_of_squares;
    }
};