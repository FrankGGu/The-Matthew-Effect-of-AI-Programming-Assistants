class Solution {
public:
    int maximumOr(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0), suffix(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] | nums[i];
        }

        for (int i = n - 1; i >= 0; --i) {
            suffix[i] = suffix[i + 1] | nums[i];
        }

        int maxOr = 0;
        for (int i = 0; i < n; ++i) {
            maxOr = max(maxOr, prefix[i] | (nums[i] + k) | suffix[i + 1]);
        }

        return maxOr;
    }
};