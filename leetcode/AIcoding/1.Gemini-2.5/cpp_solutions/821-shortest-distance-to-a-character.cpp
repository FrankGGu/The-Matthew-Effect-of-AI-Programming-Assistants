#include <string>
#include <vector>
#include <algorithm> // For std::min

class Solution {
public:
    std::vector<int> shortestToChar(std::string s, char c) {
        int n = s.length();
        std::vector<int> ans(n);

        int prev = -n; // Initialize with a value far to the left

        // First pass: left to right
        // Calculate distance to the nearest 'c' on the left or at the current position
        for (int i = 0; i < n; ++i) {
            if (s[i] == c) {
                prev = i;
            }
            ans[i] = i - prev;
        }

        prev = 2 * n; // Initialize with a value far to the right

        // Second pass: right to left
        // Calculate distance to the nearest 'c' on the right or at the current position,
        // and take the minimum with the distance already calculated.
        for (int i = n - 1; i >= 0; --i) {
            if (s[i] == c) {
                prev = i;
            }
            ans[i] = std::min(ans[i], prev - i);
        }

        return ans;
    }
};