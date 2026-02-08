#include <vector>

class Solution {
public:
    int numberOfAlternatingGroups(std::vector<int>& colors, int k) {
        int n = colors.size();
        int ans = 0;
        int current_streak = 1;

        for (int i = 1; i < n + k - 1; ++i) {
            if (colors[i % n] != colors[(i - 1) % n]) {
                current_streak++;
            } else {
                current_streak = 1;
            }

            if (i >= k - 1 && current_streak >= k) {
                ans++;
            }
        }

        return ans;
    }
};