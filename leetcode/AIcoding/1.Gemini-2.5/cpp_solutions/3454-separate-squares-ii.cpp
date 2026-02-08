#include <cmath>
#include <vector>
#include <algorithm>

class Solution {
public:
    int numSquares(int n) {
        if (n <= 0) {
            return 0;
        }

        int root = static_cast<int>(sqrt(n));
        if (root * root == n) {
            return 1;
        }

        int temp = n;
        while (temp % 4 == 0) {
            temp /= 4;
        }
        if (temp % 8 == 7) {
            return 4;
        }

        for (int i = 1; i * i <= n; ++i) {
            int remainder = n - i * i;
            int remainder_root = static_cast<int>(sqrt(remainder));
            if (remainder_root * remainder_root == remainder) {
                return 2;
            }
        }

        return 3;
    }
};