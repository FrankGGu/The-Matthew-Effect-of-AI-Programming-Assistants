#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    bool isFascinating(int n) {
        long long n2 = (long long)n * 2;
        long long n3 = (long long)n * 3;

        std::string s = std::to_string(n) + std::to_string(n2) + std::to_string(n3);

        if (s.length() != 9) {
            return false;
        }

        std::vector<bool> seen(10, false); // Index 0 for digit 0, 1 for digit 1, etc.

        for (char c : s) {
            int digit = c - '0';
            if (digit == 0 || seen[digit]) {
                return false;
            }
            seen[digit] = true;
        }

        // After checking for 0s and duplicates, we need to ensure all digits 1-9 are present.
        // Since the length is 9, and there are no 0s and no duplicates,
        // it implicitly means all digits 1-9 must be present exactly once.
        return true;
    }
};