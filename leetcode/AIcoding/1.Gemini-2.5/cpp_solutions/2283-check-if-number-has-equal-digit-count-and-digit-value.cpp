#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    bool digitCount(std::string num) {
        std::vector<int> counts(10, 0);
        for (char c : num) {
            counts[c - '0']++;
        }

        for (int i = 0; i < num.length(); ++i) {
            int expected_count = num[i] - '0';
            int actual_count = counts[i];
            if (expected_count != actual_count) {
                return false;
            }
        }
        return true;
    }
};