class Solution {
public:
    long long countMonotonicPairs(vector<int>& nums) {
        long long count = 0;
        int n = nums.size();
        vector<int> left(n, 1), right(n, 1);

        for (int i = 1; i < n; ++i) {
            if (nums[i] >= nums[i - 1]) left[i] = left[i - 1] + 1;
        }

        for (int i = n - 2; i >= 0; --i) {
            if (nums[i] <= nums[i + 1]) right[i] = right[i + 1] + 1;
        }

        for (int i = 0; i < n; ++i) {
            count += (long long)left[i] * right[i];
        }

        return count;
    }
};