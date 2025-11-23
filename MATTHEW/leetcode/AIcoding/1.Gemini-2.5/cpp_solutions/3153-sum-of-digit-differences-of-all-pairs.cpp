#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long sumDigitDifferences(vector<int>& nums) {
        long long n = nums.size();
        long long ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                string s1 = to_string(nums[i]);
                string s2 = to_string(nums[j]);
                int mn = min(s1.size(), s2.size());
                int diff = 0;
                for (int k = 0; k < mn; ++k) {
                    diff += abs((s1[s1.size() - 1 - k] - '0') - (s2[s2.size() - 1 - k] - '0'));
                }

                ans += diff;
            }
        }
        return ans * 2;
    }
};