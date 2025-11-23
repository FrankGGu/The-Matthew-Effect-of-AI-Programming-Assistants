class Solution {
public:
    vector<int> distinctDifferenceArray(vector<int>& nums) {
        int n = nums.size();
        vector<int> diff(n);
        unordered_set<int> prefix, suffix;
        vector<int> prefixCount(n), suffixCount(n);

        for (int i = 0; i < n; ++i) {
            prefix.insert(nums[i]);
            prefixCount[i] = prefix.size();
        }

        for (int i = n - 1; i >= 0; --i) {
            suffixCount[i] = suffix.size();
            suffix.insert(nums[i]);
        }

        for (int i = 0; i < n; ++i) {
            diff[i] = prefixCount[i] - suffixCount[i];
        }

        return diff;
    }
};