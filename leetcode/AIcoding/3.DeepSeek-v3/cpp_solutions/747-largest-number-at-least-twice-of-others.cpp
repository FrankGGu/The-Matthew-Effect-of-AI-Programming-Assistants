class Solution {
public:
    int dominantIndex(vector<int>& nums) {
        if (nums.size() == 1) return 0;
        int max_value = nums[0];
        int max_index = 0;
        int second_max = -1;
        for (int i = 1; i < nums.size(); i++) {
            if (nums[i] > max_value) {
                second_max = max_value;
                max_value = nums[i];
                max_index = i;
            } else if (nums[i] > second_max) {
                second_max = nums[i];
            }
        }
        return (max_value >= 2 * second_max) ? max_index : -1;
    }
};