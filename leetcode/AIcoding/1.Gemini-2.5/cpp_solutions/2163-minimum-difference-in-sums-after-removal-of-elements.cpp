#include <vector>
#include <queue>
#include <algorithm>
#include <climits>

class Solution {
public:
    long long minimumDifference(std::vector<int>& nums) {
        int N = nums.size();
        int n = N / 3;

        std::vector<long long> prefix_min(N);
        std::priority_queue<int> max_heap;
        long long current_sum = 0;

        for (int i = 0; i < n; ++i) {
            max_heap.push(nums[i]);
            current_sum += nums[i];
        }
        prefix_min[n - 1] = current_sum;

        for (int i = n; i < 2 * n; ++i) {
            max_heap.push(nums[i]);
            current_sum += nums[i];
            current_sum -= max_heap.top();
            max_heap.pop();
            prefix_min[i] = current_sum;
        }

        std::vector<long long> suffix_max(N);
        std::priority_queue<int, std::vector<int>, std::greater<int>> min_heap;
        current_sum = 0;

        for (int i = N - 1; i >= 2 * n; --i) {
            min_heap.push(nums[i]);
            current_sum += nums[i];
        }
        suffix_max[2 * n] = current_sum;

        for (int i = 2 * n - 1; i >= n; --i) {
            min_heap.push(nums[i]);
            current_sum += nums[i];
            current_sum -= min_heap.top();
            min_heap.pop();
            suffix_max[i] = current_sum;
        }

        long long min_diff = LLONG_MAX;
        for (int i = n - 1; i < 2 * n; ++i) {
            long long diff = prefix_min[i] - suffix_max[i + 1];
            min_diff = std::min(min_diff, diff);
        }

        return min_diff;
    }
};