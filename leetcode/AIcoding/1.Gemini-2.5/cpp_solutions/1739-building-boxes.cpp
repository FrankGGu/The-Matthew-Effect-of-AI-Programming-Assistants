#include <cmath>

class Solution {
public:
    int minimumBoxes(int n) {
        long long h = 0;
        long long total_boxes = 0;

        while (total_boxes + (h + 1) * (h + 2) / 2 <= n) {
            h++;
            total_boxes += h * (h + 1) / 2;
        }

        long long floor_boxes = h * (h + 1) / 2;
        long long remaining_n = n - total_boxes;

        long long k = 0;
        while (remaining_n > 0) {
            k++;
            remaining_n -= k;
        }

        return static_cast<int>(floor_boxes + k);
    }
};