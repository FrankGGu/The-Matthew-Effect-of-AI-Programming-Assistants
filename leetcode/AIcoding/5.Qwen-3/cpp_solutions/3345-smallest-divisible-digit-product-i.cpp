#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int smallestDivisibleByN(int n) {
        for (int i = 1; i <= n; ++i) {
            if (n % i == 0) {
                return i;
            }
        }
        return n;
    }
};