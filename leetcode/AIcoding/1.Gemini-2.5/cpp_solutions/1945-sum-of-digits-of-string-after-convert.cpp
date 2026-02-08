#include <string>
#include <numeric>

class Solution {
public:
    int getLucky(std::string s, int k) {
        std::string digit_str = "";
        for (char c : s) {
            digit_str += std::to_string(c - 'a' + 1);
        }

        for (int i = 0; i < k; ++i) {
            long long current_sum = 0;
            for (char d : digit_str) {
                current_sum += (d - '0');
            }

            if (i == k - 1) {
                return static_cast<int>(current_sum);
            }

            digit_str = std::to_string(current_sum);
        }

        return 0; // Should not be reached given k >= 1
    }
};