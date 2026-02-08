#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    double nthPersonGetsNthSeat(int n) {
        if (n == 1) return 1.0;
        return 1.0 / n;
    }
};