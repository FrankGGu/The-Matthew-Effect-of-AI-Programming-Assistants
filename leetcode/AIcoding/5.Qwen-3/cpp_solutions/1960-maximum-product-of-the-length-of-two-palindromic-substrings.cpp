#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxProduct(string s) {
        int n = s.length();
        vector<vector<bool>> isPalindrome(n, vector<bool>(n, false));

        for (int i = 0; i < n; ++i) {
            isPalindrome[i][i] = true;
        }

        for (int i = 0; i < n - 1; ++i) {
            if (s[i] == s[i + 1]) {
                isPalindrome[i][i + 1] = true;
            }
        }

        for (int length = 3; length <= n; ++length) {
            for (int i = 0; i <= n - length; ++i) {
                int j = i + length - 1;
                if (s[i] == s[j] && isPalindrome[i + 1][j - 1]) {
                    isPalindrome[i][j] = true;
                }
            }
        }

        vector<int> leftMax(n, 0);
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                if (isPalindrome[i][j]) {
                    leftMax[i] = max(leftMax[i], j - i + 1);
                }
            }
        }

        vector<int> rightMax(n, 0);
        for (int i = n - 1; i >= 0; --i) {
            for (int j = i; j >= 0; --j) {
                if (isPalindrome[j][i]) {
                    rightMax[i] = max(rightMax[i], i - j + 1);
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n - 1; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (isPalindrome[i][j]) {
                    result = max(result, leftMax[i] * rightMax[j]);
                }
            }
        }

        return result;
    }
};