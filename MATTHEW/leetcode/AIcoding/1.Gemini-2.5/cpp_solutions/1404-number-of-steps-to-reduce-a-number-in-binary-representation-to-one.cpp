#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int numSteps(std::string s) {
        int n = s.length();
        int steps = 0;
        int carry = 0;

        for (int i = n - 1; i > 0; --i) {
            int digit = s[i] - '0';
            if (digit + carry == 1) {
                carry = 1;
                steps += 2;
            } else {
                steps += 1;
            }
        }

        if (carry == 1) {
            steps += 1;
        }

        return steps;
    }
};