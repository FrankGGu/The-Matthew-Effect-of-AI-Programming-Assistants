#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int furthestDistanceFromOrigin(string moves) {
        int left = 0, right = 0, underscore = 0;
        for (char move : moves) {
            if (move == 'L') {
                left++;
            } else if (move == 'R') {
                right++;
            } else {
                underscore++;
            }
        }
        return abs(right - left) + underscore;
    }
};