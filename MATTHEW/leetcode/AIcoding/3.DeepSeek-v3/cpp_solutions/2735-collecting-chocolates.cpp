class Solution {
public:
    long long minCost(vector<int>& nums, int x) {
        int n = nums.size();
        vector<long long> res(n);
        for (int i = 0; i < n; ++i) {
            res[i] += 1LL * i * x;
            int cur = nums[i];
            for (int k = 0; k < n; ++k) {
                cur = min(cur, nums[(i - k + n) % n]);
                res[k] += cur;
            }
        }
        return *min_element(res.begin(), res.end());
    }
};