class Solution {
public:
    vector<long long> findPrefixScore(vector<int>& nums) {
        int n = nums.size();
        vector<long long> res(n);
        int max_val = 0;
        long long sum = 0;
        for (int i = 0; i < n; ++i) {
            max_val = max(max_val, nums[i]);
            sum += nums[i] + max_val;
            res[i] = sum;
        }
        return res;
    }
};