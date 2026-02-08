#include <vector>
#include <cmath>
#include <numeric>

class Solution {
public:
    const double EPSILON = 1e-6;

    bool solve(std::vector<double>& nums) {
        if (nums.size() == 1) {
            return std::abs(nums[0] - 24.0) < EPSILON;
        }

        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j < nums.size(); ++j) {
                std::vector<double> next_nums;
                for (int k = 0; k < nums.size(); ++k) {
                    if (k != i && k != j) {
                        next_nums.push_back(nums[k]);
                    }
                }

                double a = nums[i];
                double b = nums[j];

                next_nums.push_back(a + b);
                if (solve(next_nums)) return true;
                next_nums.pop_back();

                next_nums.push_back(a - b);
                if (solve(next_nums)) return true;
                next_nums.pop_back();

                next_nums.push_back(b - a);
                if (solve(next_nums)) return true;
                next_nums.pop_back();

                next_nums.push_back(a * b);
                if (solve(next_nums)) return true;
                next_nums.pop_back();

                if (std::abs(b) > EPSILON) {
                    next_nums.push_back(a / b);
                    if (solve(next_nums)) return true;
                    next_nums.pop_back();
                }

                if (std::abs(a) > EPSILON) {
                    next_nums.push_back(b / a);
                    if (solve(next_nums)) return true;
                    next_nums.pop_back();
                }
            }
        }
        return false;
    }

    bool judgePoint24(std::vector<int>& cards) {
        std::vector<double> nums_double;
        for (int card : cards) {
            nums_double.push_back(static_cast<double>(card));
        }
        return solve(nums_double);
    }
};