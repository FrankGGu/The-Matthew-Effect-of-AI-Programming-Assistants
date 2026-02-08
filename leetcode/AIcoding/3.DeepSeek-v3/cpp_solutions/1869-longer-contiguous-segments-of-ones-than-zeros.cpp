#include <string>
using namespace std;

class Solution {
public:
    bool checkZeroOnes(string s) {
        int max_ones = 0, max_zeros = 0;
        int current_ones = 0, current_zeros = 0;

        for (char c : s) {
            if (c == '1') {
                current_ones++;
                current_zeros = 0;
                if (current_ones > max_ones) {
                    max_ones = current_ones;
                }
            } else {
                current_zeros++;
                current_ones = 0;
                if (current_zeros > max_zeros) {
                    max_zeros = current_zeros;
                }
            }
        }

        return max_ones > max_zeros;
    }
};