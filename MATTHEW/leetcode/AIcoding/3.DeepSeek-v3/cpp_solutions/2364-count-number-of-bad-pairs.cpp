class Solution {
public:
    long long countBadPairs(vector<int>& nums) {
        unordered_map<int, int> freq;
        long long total = 0;
        long long good = 0;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            int key = nums[i] - i;
            good += freq[key];
            freq[key]++;
        }

        total = (long long)n * (n - 1) / 2;
        return total - good;
    }
};