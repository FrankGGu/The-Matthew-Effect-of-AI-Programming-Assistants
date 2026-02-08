#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countNumbersWithNonDecreasingDigits(int n) {
        vector<int> dp(10, 1);
        for (int i = 2; i <= 10; ++i) {
            for (int j = 1; j < 10; ++j) {
                dp[j] += dp[j - 1];
            }
        }

        int result = 0;
        int num = n;
        vector<int> digits;
        while (num > 0) {
            digits.push_back(num % 10);
            num /= 10;
        }
        reverse(digits.begin(), digits.end());

        int m = digits.size();
        for (int i = 1; i < m; ++i) {
            for (int j = 1; j <= 9; ++j) {
                result += dp[j];
            }
        }

        vector<int> prev(10, 0);
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < digits[i]; ++j) {
                if (i == 0 || j >= prev[j]) {
                    result += dp[j];
                }
            }
            if (i > 0 && digits[i] < digits[i - 1]) break;
            prev[digits[i]]++;
        }

        return result + 1;
    }
};