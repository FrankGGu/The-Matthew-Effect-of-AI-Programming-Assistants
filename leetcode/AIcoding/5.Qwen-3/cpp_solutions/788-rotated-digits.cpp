#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int rotatedDigits(int n) {
        int count = 0;
        for (int i = 1; i <= n; ++i) {
            bool valid = true;
            bool hasChanged = false;
            int num = i;
            while (num > 0) {
                int digit = num % 10;
                if (digit == 3 || digit == 4 || digit == 7) {
                    valid = false;
                    break;
                }
                if (digit == 2 || digit == 5 || digit == 6 || digit == 9) {
                    hasChanged = true;
                }
                num /= 10;
            }
            if (valid && hasChanged) {
                ++count;
            }
        }
        return count;
    }
};