class Solution {
public:
    bool checkArray(vector<int>& nums, int k) {
        int n = nums.size();
        vector<long long> diff(n, 0);
        long long currentSum = 0;
        for (int i = 0; i < n; ++i) {
            currentSum += diff[i];
            if (nums[i] < currentSum) {
                return false;
            }
            long long need = nums[i] - currentSum;
            if (i + k > n) {
                return false;
            }
            currentSum = nums[i];
            diff[i] = need;
            if (i + k < n) {
                diff[i + k] = -need;
            }
        }
        return true;
    }
};