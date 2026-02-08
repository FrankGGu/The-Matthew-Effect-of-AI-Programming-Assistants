class Solution {
public:
    int sumCounts(vector<int>& nums) {
        int n = nums.size();
        int total = 0;
        for (int i = 0; i < n; ++i) {
            unordered_set<int> distinct;
            for (int j = i; j < n; ++j) {
                distinct.insert(nums[j]);
                total += distinct.size() * distinct.size();
            }
        }
        return total;
    }
};