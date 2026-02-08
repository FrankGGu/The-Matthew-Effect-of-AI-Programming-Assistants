class Solution {
public:
    int smallestRangeI(vector<int>& nums, int k) {
        int min_num = *min_element(nums.begin(), nums.end());
        int max_num = *max_element(nums.begin(), nums.end());
        return max(0, max_num - min_num - 2 * k);
    }
};