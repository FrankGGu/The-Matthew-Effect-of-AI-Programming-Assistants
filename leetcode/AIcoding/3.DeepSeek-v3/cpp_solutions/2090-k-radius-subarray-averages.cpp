class Solution {
public:
    vector<int> getAverages(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> res(n, -1);
        if (2 * k + 1 > n) return res;
        long long sum = 0;
        for (int i = 0; i < 2 * k + 1; ++i) {
            sum += nums[i];
        }
        res[k] = sum / (2 * k + 1);
        for (int i = k + 1; i + k < n; ++i) {
            sum += nums[i + k] - nums[i - k - 1];
            res[i] = sum / (2 * k + 1);
        }
        return res;
    }
};