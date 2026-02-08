#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int evenOddBit(int n) {
        int even = 0, odd = 0;
        int bit = 0;
        while (n > 0) {
            if (n & 1) {
                if (bit % 2 == 0) {
                    even++;
                } else {
                    odd++;
                }
            }
            n >>= 1;
            bit++;
        }
        return even - odd;
    }
};