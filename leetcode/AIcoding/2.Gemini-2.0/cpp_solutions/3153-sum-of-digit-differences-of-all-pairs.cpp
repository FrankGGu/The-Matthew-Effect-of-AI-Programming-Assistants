#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int sumDigitDifference(vector<int>& nums) {
        int n = nums.size();
        long long ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                string s1 = to_string(nums[i]);
                string s2 = to_string(nums[j]);
                int minDigit1 = 9, maxDigit1 = 0;
                int minDigit2 = 9, maxDigit2 = 0;
                for (char c : s1) {
                    int digit = c - '0';
                    minDigit1 = min(minDigit1, digit);
                    maxDigit1 = max(maxDigit1, digit);
                }
                for (char c : s2) {
                    int digit = c - '0';
                    minDigit2 = min(minDigit2, digit);
                    maxDigit2 = max(maxDigit2, digit);
                }
                ans += abs(maxDigit1 - minDigit1) + abs(maxDigit2 - minDigit2);
            }
        }
        return ans;
    }
};