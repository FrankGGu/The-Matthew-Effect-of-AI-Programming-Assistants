#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSumDivThree(vector<int>& nums) {
        vector<int> dp = {0};
        for (int num : nums) {
            vector<int> temp = dp;
            for (int sum : dp) {
                int new_sum = sum + num;
                if (new_sum % 3 == 0) {
                    temp.push_back(new_sum);
                }
            }
            sort(temp.begin(), temp.end());
            dp = temp;
        }
        return dp.back();
    }
};