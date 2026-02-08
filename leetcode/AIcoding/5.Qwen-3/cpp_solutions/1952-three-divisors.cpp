#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool isThree(int n) {
        if (n < 2) return false;
        int count = 0;
        for (int i = 1; i <= n; ++i) {
            if (n % i == 0) {
                ++count;
                if (count > 3) return false;
            }
        }
        return count == 3;
    }
};