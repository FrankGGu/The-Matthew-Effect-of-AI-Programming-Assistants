class Solution {
public:
    int binaryGap(int n) {
        int last = -1, max_gap = 0;
        for (int i = 0; i < 32; ++i) {
            if (n & (1 << i)) {
                if (last != -1) {
                    max_gap = max(max_gap, i - last);
                }
                last = i;
            }
        }
        return max_gap;
    }
};