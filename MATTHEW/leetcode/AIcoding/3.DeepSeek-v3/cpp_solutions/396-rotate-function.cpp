class Solution {
public:
    int maxRotateFunction(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;
        long long sum = 0, f = 0;
        for (int i = 0; i < n; ++i) {
            sum += nums[i];
            f += i * nums[i];
        }
        long long res = f;
        for (int i = n - 1; i >= 1; --i) {
            f = f + sum - (long long)n * nums[i];
            if (f > res) res = f;
        }
        return res;
    }
};