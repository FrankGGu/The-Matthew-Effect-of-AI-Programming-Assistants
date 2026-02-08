#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPalindromicSubsequenceProduct(string s) {
        int n = s.length();
        vector<vector<bool>> dp(n, vector<bool>(n, false));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = true;
        }

        for (int length = 2; length <= n; ++length) {
            for (int i = 0; i <= n - length; ++i) {
                int j = i + length - 1;
                if (s[i] == s[j]) {
                    if (length == 2) {
                        dp[i][j] = true;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1];
                    }
                } else {
                    dp[i][j] = false;
                }
            }
        }

        vector<int> palindromes;
        for (int mask = 1; mask < (1 << n); ++mask) {
            string subseq;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    subseq += s[i];
                }
            }
            bool isPalindrome = true;
            for (int l = 0, r = subseq.length() - 1; l < r; ++l, --r) {
                if (subseq[l] != subseq[r]) {
                    isPalindrome = false;
                    break;
                }
            }
            if (isPalindrome) {
                palindromes.push_back(subseq.length());
            }
        }

        sort(palindromes.begin(), palindromes.end());
        int maxProd = 0;
        for (int i = 0; i < palindromes.size(); ++i) {
            for (int j = i + 1; j < palindromes.size(); ++j) {
                maxProd = max(maxProd, palindromes[i] * palindromes[j]);
            }
        }

        return maxProd;
    }
};