class Solution {
public:
    int maxAbsoluteSum(vector<int>& nums) {
        int max_sum = 0, min_sum = 0;
        int current_max = 0, current_min = 0;
        for (int num : nums) {
            current_max = max(num, current_max + num);
            current_min = min(num, current_min + num);
            max_sum = max(max_sum, current_max);
            min_sum = min(min_sum, current_min);
        }
        return max(max_sum, -min_sum);
    }
};