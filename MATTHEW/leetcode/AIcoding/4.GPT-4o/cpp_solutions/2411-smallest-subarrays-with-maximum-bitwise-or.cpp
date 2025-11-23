class Solution {
public:
    vector<int> smallestSubarrays(vector<int>& nums) {
        int n = nums.size();
        vector<int> res(n);
        vector<int> maxBit(32, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < 32; ++j) {
                if (nums[i] & (1 << j)) {
                    maxBit[j] = max(maxBit[j], i);
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            int maxOR = 0, end = i;
            while (end < n && (maxOR | nums[end]) == maxOR) {
                maxOR |= nums[end];
                end++;
            }
            res[i] = end - i;
        }

        for (int i = n - 1; i >= 0; --i) {
            int maxOR = 0, minLength = INT_MAX;
            for (int j = i; j < n; ++j) {
                maxOR |= nums[j];
                minLength = min(minLength, j - i + 1);
                res[i] = min(res[i], minLength);
            }
        }

        return res;
    }
};