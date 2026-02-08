#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> maxScoreIndices(std::vector<int>& nums) {
        int n = nums.size();

        int right_ones = 0;
        for (int x : nums) {
            if (x == 1) {
                right_ones++;
            }
        }

        int left_zeros = 0;
        int max_score = -1;
        std::vector<int> result;

        for (int i = 0; i <= n; ++i) {
            int current_score = left_zeros + right_ones;

            if (current_score > max_score) {
                max_score = current_score;
                result = {i};
            } else if (current_score == max_score) {
                result.push_back(i);
            }

            if (i < n) {
                if (nums[i] == 0) {
                    left_zeros++;
                } else {
                    right_ones--;
                }
            }
        }

        return result;
    }
};