class Solution {
public:
    int minSubarray(vector<int>& nums, int p) {
        long long total = accumulate(nums.begin(), nums.end(), 0LL);
        long long target = total % p;
        if (target == 0) return 0;

        unordered_map<long long, int> prefix;
        prefix[0] = -1;
        long long curr_sum = 0;
        int min_length = INT_MAX;

        for (int i = 0; i < nums.size(); ++i) {
            curr_sum = (curr_sum + nums[i]) % p;
            prefix[curr_sum] = i;

            long long needed = (curr_sum - target + p) % p;
            if (prefix.count(needed)) {
                min_length = min(min_length, i - prefix[needed]);
            }
        }

        return min_length == INT_MAX ? -1 : min_length;
    }
};