class Solution {
public:
    int minimizeArrayLength(vector<int>& nums) {
        unordered_set<int> unique_nums(nums.begin(), nums.end());
        return unique_nums.size();
    }
};