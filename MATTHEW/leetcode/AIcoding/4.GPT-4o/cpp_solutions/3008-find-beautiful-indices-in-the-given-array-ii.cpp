class Solution {
public:
    vector<int> beautifulIndices(vector<int>& nums) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0), suffix(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            prefix[i] = prefix[i - 1] + (nums[i - 1] % 2 == 0);
        }
        for (int i = n - 1; i >= 0; --i) {
            suffix[i] = suffix[i + 1] + (nums[i] % 2 == 0);
        }
        vector<int> result;
        for (int i = 0; i < n; ++i) {
            if (prefix[i] == suffix[i + 1]) {
                result.push_back(i);
            }
        }
        return result;
    }
};