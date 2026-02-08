#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int makeTheIntegerZero(int n, int m) {
        int count = 0;
        while (n > 0) {
            if (n % 2 == 1) {
                count++;
            }
            n /= 2;
        }
        return max(count, m);
    }
};