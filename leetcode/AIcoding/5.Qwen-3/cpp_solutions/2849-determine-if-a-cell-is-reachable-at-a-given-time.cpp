#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool isReachable(int height, int width, int time) {
        if (time == 0) return true;
        if ((height + width) % 2 == 0) {
            return time >= 2;
        } else {
            return time >= 1;
        }
    }
};