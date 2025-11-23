#include <string>
#include <vector>
#include <cmath>
#include <algorithm>

class Solution {
public:
    int equalSubstring(std::string s, std::string t, int maxCost) {
        int n = s.length();
        int left = 0;
        int current_cost = 0;
        int max_length = 0;

        for (int right = 0; right < n; ++right) {
            current_cost += std::abs(s[right] - t[right]);

            while (current_cost > maxCost) {
                current_cost -= std::abs(s[left] - t[left]);
                left++;
            }
            max_length = std::max(max_length, right - left + 1);
        }

        return max_length;
    }
};