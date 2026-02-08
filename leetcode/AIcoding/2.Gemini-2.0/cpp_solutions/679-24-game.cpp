#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    bool judgePoint24(vector<int>& nums) {
        vector<double> doubleNums(nums.begin(), nums.end());
        return solve(doubleNums);
    }

    bool solve(vector<double>& nums) {
        if (nums.size() == 1) {
            return abs(nums[0] - 24) < 1e-6;
        }

        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j < nums.size(); ++j) {
                vector<double> nextNums;
                for (int k = 0; k < nums.size(); ++k) {
                    if (k != i && k != j) {
                        nextNums.push_back(nums[k]);
                    }
                }

                double a = nums[i];
                double b = nums[j];

                nextNums.push_back(a + b);
                if (solve(nextNums)) return true;
                nextNums.pop_back();

                nextNums.push_back(a - b);
                if (solve(nextNums)) return true;
                nextNums.pop_back();

                nextNums.push_back(b - a);
                if (solve(nextNums)) return true;
                nextNums.pop_back();

                nextNums.push_back(a * b);
                if (solve(nextNums)) return true;
                nextNums.pop_back();

                if (abs(b) > 1e-6) {
                    nextNums.push_back(a / b);
                    if (solve(nextNums)) return true;
                    nextNums.pop_back();
                }
                if (abs(a) > 1e-6) {
                    nextNums.push_back(b / a);
                    if (solve(nextNums)) return true;
                    nextNums.pop_back();
                }
            }
        }

        return false;
    }
};