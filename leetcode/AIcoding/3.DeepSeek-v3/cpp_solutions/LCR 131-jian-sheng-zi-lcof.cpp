#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int cuttingBamboo(int n) {
        if (n <= 3) {
            return n - 1;
        }
        int res = 1;
        while (n > 4) {
            res *= 3;
            n -= 3;
        }
        return res * n;
    }
};