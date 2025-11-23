class Solution {
public:
    int countOccurrences(vector<int>& nums, int target) {
        return count(nums.begin(), nums.end(), target);
    }
};