class Solution {
public:
    vector<long long> productExceptSelf(vector<int>& nums) {
        int n = nums.size();
        vector<long long> result(n, 1);
        long long left = 1, right = 1;

        for (int i = 0; i < n; i++) {
            result[i] *= left;
            left *= nums[i];
        }

        for (int i = n - 1; i >= 0; i--) {
            result[i] *= right;
            right *= nums[i];
        }

        return result;
    }
};