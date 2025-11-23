#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int binaryGap(int n) {
        int maxDistance = 0;
        int lastPosition = -1;
        int position = 0;

        while (n > 0) {
            if (n & 1) {
                if (lastPosition != -1) {
                    maxDistance = max(maxDistance, position - lastPosition);
                }
                lastPosition = position;
            }
            n >>= 1;
            position++;
        }

        return maxDistance;
    }
};