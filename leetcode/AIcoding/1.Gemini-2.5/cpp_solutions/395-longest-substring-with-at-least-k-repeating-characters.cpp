#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int longestSubstring(std::string s, int k) {
        return solve(s, 0, s.length(), k);
    }

private:
    int solve(const std::string& s, int start, int end, int k) {
        if (end - start < k) {
            return 0;
        }

        std::vector<int> counts(26, 0);
        for (int i = start; i < end; ++i) {
            counts[s[i] - 'a']++;
        }

        for (int i = start; i < end; ++i) {
            if (counts[s[i] - 'a'] < k) {
                int left = solve(s, start, i, k);
                int right = solve(s, i + 1, end, k);
                return std::max(left, right);
            }
        }

        return end - start;
    }
};