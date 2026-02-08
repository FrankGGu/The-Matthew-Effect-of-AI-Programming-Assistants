class Solution {
public:
    long long countMonotonicPairs(vector<int>& nums) {
        long long count = 0, n = nums.size();
        vector<long long> left(n), right(n);

        for (int i = 0; i < n; ++i) {
            left[i] = (i == 0 || nums[i] >= nums[i - 1]) ? (i == 0 ? 1 : left[i - 1] + 1) : 1;
        }

        for (int i = n - 1; i >= 0; --i) {
            right[i] = (i == n - 1 || nums[i] <= nums[i + 1]) ? (i == n - 1 ? 1 : right[i + 1] + 1) : 1;
        }

        for (int i = 0; i < n; ++i) {
            count += (left[i] * right[i]) - 1;
        }

        return count;
    }
};