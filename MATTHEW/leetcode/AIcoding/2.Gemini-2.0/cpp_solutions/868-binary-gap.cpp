#include <algorithm>

using namespace std;

class Solution {
public:
    int binaryGap(int n) {
        int lastBit = -1;
        int maxGap = 0;
        for (int i = 0; i < 32; ++i) {
            if ((n >> i) & 1) {
                if (lastBit != -1) {
                    maxGap = max(maxGap, i - lastBit);
                }
                lastBit = i;
            }
        }
        return maxGap;
    }
};