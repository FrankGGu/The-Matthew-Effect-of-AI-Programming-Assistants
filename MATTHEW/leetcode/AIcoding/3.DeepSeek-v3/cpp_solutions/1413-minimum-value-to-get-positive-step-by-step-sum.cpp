class Solution {
public:
    int minStartValue(vector<int>& nums) {
        int min_sum = 0;
        int current_sum = 0;
        for (int num : nums) {
            current_sum += num;
            if (current_sum < min_sum) {
                min_sum = current_sum;
            }
        }
        return 1 - min_sum;
    }
};