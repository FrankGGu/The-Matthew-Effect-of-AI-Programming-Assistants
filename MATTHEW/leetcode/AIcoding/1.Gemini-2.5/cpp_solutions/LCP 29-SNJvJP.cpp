#include <algorithm>

class Solution {
public:
    int orchestraLayout(int num, int xPos, int yPos) {
        long long n = num;
        long long x = xPos;
        long long y = yPos;

        long long k = std::min({x, y, n - 1 - x, n - 1 - y});

        long long total_before = 4LL * k * (n - k);
        long long side = n - 2 * k;

        long long total_count;

        if (x == k) {
            total_count = total_before + (y - k) + 1;
        } else if (y == n - 1 - k) {
            total_count = total_before + (side - 1) + (x - k) + 1;
        } else if (x == n - 1 - k) {
            total_count = total_before + (side - 1) * 2 + (n - 1 - k - y) + 1;
        } else {
            total_count = total_before + (side - 1) * 3 + (n - 1 - k - x) + 1;
        }

        return (total_count - 1) % 9 + 1;
    }
};