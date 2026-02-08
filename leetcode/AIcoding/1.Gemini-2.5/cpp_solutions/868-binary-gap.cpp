#include <algorithm> // Required for std::max

class Solution {
public:
    int binaryGap(int n) {
        int max_gap = 0;
        int last_one_pos = -1;
        int current_pos = 0;

        while (n > 0) {
            if ((n & 1) == 1) {
                if (last_one_pos != -1) {
                    max_gap = std::max(max_gap, current_pos - last_one_pos);
                }
                last_one_pos = current_pos;
            }
            n >>= 1;
            current_pos++;
        }

        return max_gap;
    }
};