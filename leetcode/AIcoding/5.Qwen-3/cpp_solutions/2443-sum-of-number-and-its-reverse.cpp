#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool sumOfNumberAndReverse(int num) {
        for (int i = 0; i <= num; ++i) {
            int rev = 0;
            int n = i;
            while (n > 0) {
                rev = rev * 10 + n % 10;
                n /= 10;
            }
            if (i + rev == num) {
                return true;
            }
        }
        return false;
    }
};