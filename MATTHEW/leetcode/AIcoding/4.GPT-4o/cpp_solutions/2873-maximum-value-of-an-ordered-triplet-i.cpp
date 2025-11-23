class Solution {
public:
    int maximumTripletValue(vector<int>& nums) {
        int max_value = 0;
        int max_a = 0;
        for (int i = 0; i < nums.size(); ++i) {
            max_a = max(max_a, nums[i]);
            for (int j = i + 1; j < nums.size(); ++j) {
                if (j > i + 1) {
                    max_value = max(max_value, max_a - nums[j] + nums[j + 1]);
                }
            }
        }
        return max_value;
    }
};