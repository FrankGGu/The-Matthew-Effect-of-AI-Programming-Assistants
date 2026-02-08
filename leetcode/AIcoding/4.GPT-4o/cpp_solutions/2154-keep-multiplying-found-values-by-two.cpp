class Solution {
public:
    int findFinalValue(vector<int>& nums, int original) {
        unordered_set<int> num_set(nums.begin(), nums.end());
        while (num_set.count(original)) {
            original *= 2;
        }
        return original;
    }
};