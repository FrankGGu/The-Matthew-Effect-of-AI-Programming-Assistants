#include <cmath>

class Solution {
public:
    int countTriples(int n) {
        int count = 0;
        for (int a = 1; a <= n; ++a) {
            for (int b = 1; b <= n; ++b) {
                int c_squared = a * a + b * b;
                double c_float = std::sqrt(c_squared);
                int c_int = static_cast<int>(c_float);

                if (c_int * c_int == c_squared && c_int <= n) {
                    count++;
                }
            }
        }
        return count;
    }
};