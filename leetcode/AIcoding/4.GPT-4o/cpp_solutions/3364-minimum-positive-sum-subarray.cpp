class Solution {
public:
    int minPositiveSum(vector<int>& nums) {
        int min_sum = INT_MAX;
        int current_sum = 0;

        for (int num : nums) {
            if (num > 0) {
                current_sum += num;
            } else {
                if (current_sum > 0) {
                    min_sum = min(min_sum, current_sum);
                }
                current_sum = 0;
            }
        }

        if (current_sum > 0) {
            min_sum = min(min_sum, current_sum);
        }

        return (min_sum == INT_MAX) ? 0 : min_sum;
    }
};