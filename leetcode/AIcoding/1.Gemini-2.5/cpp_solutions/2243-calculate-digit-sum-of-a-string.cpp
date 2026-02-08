#include <string>
#include <numeric> // Not strictly needed for this implementation, but often useful for sums

class Solution {
public:
    std::string digitSum(std::string s, int k) {
        while (s.length() > k) {
            std::string next_s = "";
            for (int i = 0; i < s.length(); i += k) {
                int current_group_sum = 0;
                for (int j = 0; j < k && (i + j) < s.length(); ++j) {
                    current_group_sum += (s[i + j] - '0');
                }
                next_s += std::to_string(current_group_sum);
            }
            s = next_s;
        }
        return s;
    }
};