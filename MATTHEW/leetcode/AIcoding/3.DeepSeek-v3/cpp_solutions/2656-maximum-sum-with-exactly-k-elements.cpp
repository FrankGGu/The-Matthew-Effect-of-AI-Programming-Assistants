class Solution {
public:
    int maximizeSum(vector<int>& nums, int k) {
        int max_num = *max_element(nums.begin(), nums.end());
        return k * max_num + k * (k - 1) / 2;
    }
};