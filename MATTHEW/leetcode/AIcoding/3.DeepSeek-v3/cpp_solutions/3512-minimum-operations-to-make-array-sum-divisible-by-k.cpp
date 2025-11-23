class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int total_sum = accumulate(nums.begin(), nums.end(), 0);
        int remainder = total_sum % k;
        if (remainder == 0) return 0;

        unordered_map<int, int> prefix_remainders;
        prefix_remainders[0] = -1;
        int min_ops = INT_MAX;
        int current_sum = 0;

        for (int i = 0; i < nums.size(); ++i) {
            current_sum += nums[i];
            int current_remainder = current_sum % k;
            int target_remainder = (current_remainder - remainder + k) % k;

            if (prefix_remainders.find(target_remainder) != prefix_remainders.end()) {
                int len = i - prefix_remainders[target_remainder];
                min_ops = min(min_ops, len);
            }

            prefix_remainders[current_remainder] = i;
        }

        return min_ops == INT_MAX ? -1 : min_ops;
    }
};