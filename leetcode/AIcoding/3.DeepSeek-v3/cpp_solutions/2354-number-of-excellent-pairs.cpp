class Solution {
public:
    long long countExcellentPairs(vector<int>& nums, int k) {
        unordered_set<int> unique_nums(nums.begin(), nums.end());
        vector<int> bits_counts;
        for (int num : unique_nums) {
            bits_counts.push_back(__builtin_popcount(num));
        }
        sort(bits_counts.begin(), bits_counts.end());
        long long res = 0;
        int n = bits_counts.size();
        for (int i = 0; i < n; ++i) {
            int target = k - bits_counts[i];
            auto it = lower_bound(bits_counts.begin(), bits_counts.end(), target);
            res += (bits_counts.end() - it);
        }
        return res;
    }
};