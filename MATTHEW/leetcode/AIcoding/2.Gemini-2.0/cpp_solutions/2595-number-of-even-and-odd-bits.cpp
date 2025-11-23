#include <vector>

using namespace std;

class Solution {
public:
    vector<int> evenOddBit(int n) {
        int evenCount = 0;
        int oddCount = 0;
        int bitPosition = 0;

        while (n > 0) {
            if (n & 1) {
                if (bitPosition % 2 == 0) {
                    evenCount++;
                } else {
                    oddCount++;
                }
            }
            n >>= 1;
            bitPosition++;
        }

        return {evenCount, oddCount};
    }
};