#include <vector>
#include <algorithm> // For std::sort and std::max/min

class Solution {
public:
    int calculateMaxGapSize(std::vector<int>& bars) {
        if (bars.size() < 2) {
            return 0;
        }
        std::sort(bars.begin(), bars.end());

        int max_consecutive_bars = 1;
        int current_consecutive_bars = 1;

        for (size_t i = 1; i < bars.size(); ++i) {
            if (bars[i] == bars[i-1] + 1) {
                current_consecutive_bars++;
            } else {
                current_consecutive_bars = 1;
            }
            max_consecutive_bars = std::max(max_consecutive_bars, current_consecutive_bars);
        }
        return max_consecutive_bars - 1;
    }

    int maximizeSquareHoleArea(int n, int m, std::vector<int>& hBars, std::vector<int>& vBars) {
        int max_h_gap = calculateMaxGapSize(hBars);
        int max_v_gap = calculateMaxGapSize(vBars);

        int side_length = std::min(max_h_gap, max_v_gap);
        return side_length * side_length;
    }
};