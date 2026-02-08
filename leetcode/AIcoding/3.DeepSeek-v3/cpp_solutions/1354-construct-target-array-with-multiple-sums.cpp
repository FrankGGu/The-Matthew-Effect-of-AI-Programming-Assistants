#include <vector>
#include <queue>
#include <numeric>

class Solution {
public:
    bool isPossible(std::vector<int>& target) {
        if (target.size() == 1) {
            return target[0] == 1;
        }

        std::priority_queue<int> max_heap(target.begin(), target.end());
        long long total_sum = std::accumulate(target.begin(), target.end(), 0LL);

        while (max_heap.top() > 1) {
            int max_val = max_heap.top();
            max_heap.pop();
            long long remaining_sum = total_sum - max_val;

            if (remaining_sum == 1) {
                return true;
            }

            if (remaining_sum == 0 || max_val <= remaining_sum) {
                return false;
            }

            int new_val = max_val % remaining_sum;
            if (new_val == 0) {
                return false;
            }

            total_sum = remaining_sum + new_val;
            max_heap.push(new_val);
        }

        return true;
    }
};