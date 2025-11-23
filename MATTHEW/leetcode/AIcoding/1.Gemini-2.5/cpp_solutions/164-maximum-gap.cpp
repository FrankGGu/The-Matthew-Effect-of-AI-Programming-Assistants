#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int maximumGap(std::vector<int>& nums) {
        int n = nums.size();
        if (n < 2) {
            return 0;
        }

        auto minmax_pair = std::minmax_element(nums.begin(), nums.end());
        int min_val = *minmax_pair.first;
        int max_val = *minmax_pair.second;

        if (min_val == max_val) {
            return 0;
        }

        int bucket_size = std::max(1, (max_val - min_val) / (n - 1));
        int bucket_count = (max_val - min_val) / bucket_size + 1;

        std::vector<std::pair<int, int>> buckets(bucket_count, {INT_MAX, INT_MIN});

        for (int num : nums) {
            int idx = (num - min_val) / bucket_size;
            buckets[idx].first = std::min(buckets[idx].first, num);
            buckets[idx].second = std::max(buckets[idx].second, num);
        }

        int max_gap = 0;
        int prev_max = min_val;

        for (const auto& bucket : buckets) {
            if (bucket.first == INT_MAX) {
                continue;
            }
            max_gap = std::max(max_gap, bucket.first - prev_max);
            prev_max = bucket.second;
        }

        return max_gap;
    }
};