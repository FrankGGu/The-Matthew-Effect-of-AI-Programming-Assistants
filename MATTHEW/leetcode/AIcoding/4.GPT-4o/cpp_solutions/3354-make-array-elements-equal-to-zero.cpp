class Solution {
public:
    int minOperations(vector<int>& nums) {
        int maxNum = *max_element(nums.begin(), nums.end());
        return maxNum;
    }
};