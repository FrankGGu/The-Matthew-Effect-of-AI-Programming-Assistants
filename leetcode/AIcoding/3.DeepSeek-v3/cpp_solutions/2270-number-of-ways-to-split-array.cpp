class Solution {
public:
    int waysToSplitArray(vector<int>& nums) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        long long total = prefix[n];
        int res = 0;
        for (int i = 0; i < n - 1; ++i) {
            long long left = prefix[i + 1];
            long long right = total - left;
            if (left >= right) {
                res++;
            }
        }
        return res;
    }
};