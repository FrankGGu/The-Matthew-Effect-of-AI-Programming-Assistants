#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool isHarshad(int x) {
        int original = x;
        int sum = 0;
        while (x > 0) {
            sum += x % 10;
            x /= 10;
        }
        return sum != 0 && original % sum == 0;
    }
};