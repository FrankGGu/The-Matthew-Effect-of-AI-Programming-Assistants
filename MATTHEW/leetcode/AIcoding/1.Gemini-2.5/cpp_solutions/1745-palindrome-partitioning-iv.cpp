#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    bool checkPartitioning(std::string s) {
        int n = s.length();

        std::vector<std::vector<bool>> isPalindrome(n, std::vector<bool>(n, false));

        for (int i = 0; i < n; ++i) {
            isPalindrome[i][i] = true;
        }

        for (int i = 0; i < n - 1; ++i) {
            if (s[i] == s[i+1]) {
                isPalindrome[i][i+1] = true;
            }
        }

        for (int len = 3; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                if (s[i] == s[j] && isPalindrome[i+1][j-1]) {
                    isPalindrome[i][j] = true;
                }
            }
        }

        for (int i = 0; i < n - 2; ++i) { // First partition s[0...i]
            if (isPalindrome[0][i]) {
                for (int j = i + 1; j < n - 1; ++j) { // Second partition s[i+1...j]
                    if (isPalindrome[i+1][j]) {
                        // Third partition s[j+1...n-1]
                        if (isPalindrome[j+1][n-1]) {
                            return true;
                        }
                    }
                }
            }
        }

        return false;
    }
};