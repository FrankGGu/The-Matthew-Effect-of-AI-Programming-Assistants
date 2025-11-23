class Solution {
public:
    int maximumGap(vector<int>& nums) {
        if (nums.size() < 2) return 0;

        int min_val = *min_element(nums.begin(), nums.end());
        int max_val = *max_element(nums.begin(), nums.end());

        int n = nums.size();
        int bucket_size = max(1, (max_val - min_val) / (n - 1));
        int bucket_num = (max_val - min_val) / bucket_size + 1;

        vector<pair<int, int>> buckets(bucket_num, {INT_MAX, INT_MIN});

        for (int num : nums) {
            int idx = (num - min_val) / bucket_size;
            buckets[idx].first = min(buckets[idx].first, num);
            buckets[idx].second = max(buckets[idx].second, num);
        }

        int max_gap = 0;
        int prev_max = min_val;

        for (auto& bucket : buckets) {
            if (bucket.first == INT_MAX) continue;
            max_gap = max(max_gap, bucket.first - prev_max);
            prev_max = bucket.second;
        }

        return max_gap;
    }
};