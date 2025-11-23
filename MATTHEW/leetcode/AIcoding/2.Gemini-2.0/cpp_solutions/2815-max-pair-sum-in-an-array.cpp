#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSum(vector<int>& nums) {
        int max_sum = -1;
        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j < nums.size(); ++j) {
                int max_digit_i = 0;
                int temp_i = nums[i];
                while (temp_i > 0) {
                    max_digit_i = max(max_digit_i, temp_i % 10);
                    temp_i /= 10;
                }

                int max_digit_j = 0;
                int temp_j = nums[j];
                while (temp_j > 0) {
                    max_digit_j = max(max_digit_j, temp_j % 10);
                    temp_j /= 10;
                }

                if (max_digit_i == max_digit_j) {
                    max_sum = max(max_sum, nums[i] + nums[j]);
                }
            }
        }
        return max_sum;
    }
};