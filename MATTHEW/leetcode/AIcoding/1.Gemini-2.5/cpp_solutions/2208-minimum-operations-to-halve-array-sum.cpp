#include <vector>
#include <numeric>
#include <queue>
#include <functional>

class Solution {
public:
    int halveArray(std::vector<int>& nums) {
        std::priority_queue<double> pq;
        double current_sum = 0.0;
        for (int num : nums) {
            pq.push(static_cast<double>(num));
            current_sum += static_cast<double>(num);
        }

        double target_reduction = current_sum / 2.0;
        double reduced_amount = 0.0;
        int operations = 0;

        while (reduced_amount < target_reduction) {
            double largest_val = pq.top();
            pq.pop();

            double reduction_this_op = largest_val / 2.0;
            reduced_amount += reduction_this_op;

            pq.push(largest_val - reduction_this_op);
            operations++;
        }

        return operations;
    }
};