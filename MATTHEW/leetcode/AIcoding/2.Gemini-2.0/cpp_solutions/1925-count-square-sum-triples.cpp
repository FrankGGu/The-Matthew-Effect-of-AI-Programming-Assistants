#include <unordered_set>

using namespace std;

class Solution {
public:
    int countTriples(int n) {
        int count = 0;
        for (int a = 1; a <= n; ++a) {
            for (int b = 1; b <= n; ++b) {
                int c_squared = a * a + b * b;
                int c = sqrt(c_squared);
                if (c * c == c_squared && c <= n) {
                    count++;
                }
            }
        }
        return count;
    }
};