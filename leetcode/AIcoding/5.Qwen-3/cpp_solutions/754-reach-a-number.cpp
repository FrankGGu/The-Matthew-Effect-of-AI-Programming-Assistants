#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int reachNumber(int target) {
        int steps = 0;
        int position = 0;
        target = abs(target);
        while (position < target || (position - target) % 2 != 0) {
            steps++;
            position += steps;
        }
        return steps;
    }
};