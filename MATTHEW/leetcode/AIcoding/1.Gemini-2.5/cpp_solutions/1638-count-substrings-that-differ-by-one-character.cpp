#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int countSubstrings(std::string s, std::string t) {
        int n = s.length();
        int m = t.length();
        int ans = 0;

        // L[i][j] stores the length of the longest common suffix of s[0...i-1] and t[0...j-1].
        // This represents the length of the common part of substrings *before* s[i-1] and t[j-1].
        // When considering s[i] and t[j] as the differing characters, L[i][j] gives the length
        // of the common prefix that ends just before s[i] and t[j].
        std::vector<std::vector<int>> L(n + 1, std::vector<int>(m + 1, 0));
        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                if (s[i - 1] == t[j - 1]) {
                    L[i][j] = 1 + L[i - 1][j - 1];
                } else {
                    L[i][j] = 0;
                }
            }
        }

        // R[i][j] stores the length of the longest common prefix of s[i...] and t[j...].
        // This represents the length of the common part of substrings *starting from* s[i] and t[j].
        // When considering s[k] and t[l] as the differing characters, R[k+1][l+1] gives the length
        // of the common suffix that starts just after s[k] and t[l].
        std::vector<std::vector<int>> R(n + 1, std::vector<int>(m + 1, 0));
        for (int i = n - 1; i >= 0; --i) {
            for (int j = m - 1; j >= 0; --j) {
                if (s[i] == t[j]) {
                    R[i][j] = 1 + R[i + 1][j + 1];
                } else {
                    R[i][j] = 0;
                }
            }
        }

        // Iterate through all possible pairs of characters (s[i], t[j])
        // that could be the single differing character.
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (s[i] != t[j]) {
                    // If s[i] and t[j] are the single differing characters,
                    // we need to count how many valid substrings can be formed around them.
                    //
                    // The common prefix before s[i] and t[j] has length L[i][j].
                    // This means we can choose a common prefix of length k from 0 to L[i][j].
                    // Number of choices for k is (L[i][j] + 1).
                    //
                    // The common suffix after s[i] and t[j] has length R[i+1][j+1].
                    // This means we can choose a common suffix of length l from 0 to R[i+1][j+1].
                    // Number of choices for l is (R[i+1][j+1] + 1).
                    //
                    // The total number of substring pairs differing by exactly one character at (s[i], t[j])
                    // is the product of these choices.
                    ans += (L[i][j] + 1) * (R[i + 1][j + 1] + 1);
                }
            }
        }

        return ans;
    }
};