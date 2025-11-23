#include <vector>
#include <algorithm>

class Solution {
public:
    int minTaps(int n, std::vector<int>& ranges) {
        std::vector<int> max_reach(n + 1, 0);
        for (int i = 0; i <= n; ++i) {
            int start = std::max(0, i - ranges[i]);
            int end = i + ranges[i];
            max_reach[start] = std::max(max_reach[start], end);
        }

        int taps = 0;
        int current_end = 0;
        int next_end = 0;
        int i = 0;

        while (current_end < n) {
            taps++;
            while (i <= current_end) {
                next_end = std::max(next_end, max_reach[i]);
                i++;
                if (i > n) {
                    break;
                }
            }
            if (next_end <= current_end) {
                return -1;
            }
            current_end = next_end;
        }

        return taps;
    }
};