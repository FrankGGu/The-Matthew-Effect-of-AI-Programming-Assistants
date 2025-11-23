class Solution {
public:
    int findNonMinOrMax(vector<int>& nums) {
        if (nums.size() <= 2) {
            return -1;
        }
        int min_val = *min_element(nums.begin(), nums.end());
        int max_val = *max_element(nums.begin(), nums.end());
        for (int num : nums) {
            if (num != min_val && num != max_val) {
                return num;
            }
        }
        return -1;
    }
};