#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    bool judgePoint24(vector<int>& nums) {
        vector<double> temp(nums.begin(), nums.end());
        return backtrack(temp);
    }

private:
    bool backtrack(vector<double>& nums) {
        if (nums.size() == 1) {
            return abs(nums[0] - 24) < 1e-6;
        }

        for (int i = 0; i < nums.size(); ++i) {
            for (int j = 0; j < nums.size(); ++j) {
                if (i != j) {
                    vector<double> next;
                    for (int k = 0; k < nums.size(); ++k) {
                        if (k != i && k != j) {
                            next.push_back(nums[k]);
                        }
                    }

                                        next.push_back(nums[i] + nums[j]);
                    if (backtrack(next)) return true;
                    next.pop_back();

                    next.push_back(nums[i] - nums[j]);
                    if (backtrack(next)) return true;
                    next.pop_back();

                    next.push_back(nums[j] - nums[i]);
                    if (backtrack(next)) return true;
                    next.pop_back();

                    next.push_back(nums[i] * nums[j]);
                    if (backtrack(next)) return true;
                    next.pop_back();

                    if (nums[j] != 0) {
                        next.push_back(nums[i] / nums[j]);
                        if (backtrack(next)) return true;
                        next.pop_back();
                    }

                    if (nums[i] != 0) {
                        next.push_back(nums[j] / nums[i]);
                        if (backtrack(next)) return true;
                        next.pop_back();
                    }
                }
            }
        }

        return false;
    }
};