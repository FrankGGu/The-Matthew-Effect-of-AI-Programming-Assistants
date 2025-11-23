class Solution {
public:
    long long maximumTripletValue(vector<int>& nums) {
        int n = nums.size();
        vector<int> max_left(n), max_right(n);

        max_left[0] = nums[0];
        for (int i = 1; i < n; ++i) {
            max_left[i] = max(max_left[i-1], nums[i]);
        }

        max_right[n-1] = nums[n-1];
        for (int i = n-2; i >= 0; --i) {
            max_right[i] = max(max_right[i+1], nums[i]);
        }

        long long res = 0;
        for (int j = 1; j < n-1; ++j) {
            long long val = (long long)(max_left[j-1] - nums[j]) * max_right[j+1];
            if (val > res) {
                res = val;
            }
        }

        return res;
    }
};