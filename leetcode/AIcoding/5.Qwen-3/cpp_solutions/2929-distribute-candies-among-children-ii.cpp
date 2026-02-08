#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int distributeCandies(int n, int k) {
        int count = 0;
        for (int i = 1; i <= k; ++i) {
            if (n >= i) {
                n -= i;
                ++count;
            } else {
                break;
            }
        }
        return count;
    }
};