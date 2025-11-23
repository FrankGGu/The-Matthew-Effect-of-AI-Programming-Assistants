#include <vector>
#include <queue> // Required for std::priority_queue

class Solution {
public:
    bool isPossible(std::vector<int>& target) {
        // Base case: If the target array has only one element.
        // It can only be constructed if it's 1.
        if (target.size() == 1) {
            return target[0] == 1;
        }

        // Use a max-priority queue to efficiently get the largest element.
        // Use long long for elements and sum to prevent overflow, as target[i] can be up to 10^9
        // and sum can be up to 10^5 * 10^9 = 10^14.
        std::priority_queue<long long> pq;
        long long sum = 0;

        // Populate the priority queue and calculate the initial sum.
        for (int num : target) {
            pq.push(num);
            sum += num;
        }

        // Continue the process in reverse until the largest element in the priority queue is 1.
        // If all elements become 1, the array is constructible.
        while (pq.top() != 1) {
            long long max_val = pq.top();
            pq.pop();

            // Calculate the sum of all other elements in the array.
            long long other_sum = sum - max_val;

            // Critical checks for impossibility:
            // 1. If other_sum is 0, it means the array effectively has only one element.
            //    This case should have been caught by the initial target.size() == 1 check.
            //    If we reach here, it implies max_val is > 1 and other_sum is 0,
            //    which means all other elements sum to 0. This is impossible
            //    because all target[i] >= 1. So, return false.
            if (other_sum == 0) {
                return false;
            }

            // 2. The largest element must be strictly greater than the sum of the others.
            //    If max_val <= other_sum, then the previous value (max_val - other_sum)
            //    would be <= 0, which is invalid as all elements must be positive.
            //    Example: [2, 2]. max_val=2, other_sum=2. prev_val would be 0. Invalid.
            //    Example: [1, 2]. max_val=2, other_sum=1. prev_val would be 1. Valid.
            if (max_val <= other_sum) {
                return false;
            }

            // Calculate the previous value using the modulo operator for optimization.
            // The current `max_val` was formed by `prev_val + k * other_sum`.
            // We want to find the `prev_val` such that it's positive and the smallest possible
            // value that could have led to `max_val` through repeated additions of `other_sum`.
            // This is `max_val % other_sum`.
            // If `max_val % other_sum == 0`, it means `max_val` was a multiple of `other_sum`.
            // In this specific case, the previous value should be `other_sum` itself (not 0),
            // because a value of 0 is not allowed.
            long long prev_val = max_val % other_sum;
            if (prev_val == 0) {
                prev_val = other_sum;
            }

            // Update the total sum and add the calculated previous value back to the priority queue.
            sum = sum - max_val + prev_val;
            pq.push(prev_val);
        }

        // If the loop finishes, it means all elements in the priority queue are 1.
        // Thus, the target array is constructible.
        return true;
    }
};