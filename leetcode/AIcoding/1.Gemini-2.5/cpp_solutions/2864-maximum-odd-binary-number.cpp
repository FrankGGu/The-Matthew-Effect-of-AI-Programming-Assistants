#include <string>
#include <numeric> // Required for std::count if used, but a manual loop is also fine

class Solution {
public:
    std::string maximumOddBinaryNumber(std::string s) {
        int n = s.length();
        int ones_count = 0;
        for (char c : s) {
            if (c == '1') {
                ones_count++;
            }
        }

        std::string result(n, '0');

        // Place one '1' at the end to make the number odd
        result[n - 1] = '1';
        ones_count--; // Decrement count as one '1' is used

        // Place the remaining '1's at the beginning to maximize the number
        for (int i = 0; i < ones_count; ++i) {
            result[i] = '1';
        }

        return result;
    }
};