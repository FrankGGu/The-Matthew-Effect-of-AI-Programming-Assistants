#include <string>
#include <vector>

class Solution {
public:
    bool check(const std::string& s, int target, int current_sum, int index) {
        if (index == s.length()) {
            return current_sum == target;
        }

        if (current_sum > target) {
            return false;
        }

        for (int j = index; j < s.length(); ++j) {
            std::string sub_str = s.substr(index, j - index + 1);
            int val = std::stoi(sub_str);

            if (check(s, target, current_sum + val, j + 1)) {
                return true;
            }
        }
        return false;
    }

    int punishmentNumber(int n) {
        long long total_punishment_sum = 0;

        for (int i = 1; i <= n; ++i) {
            long long square = (long long)i * i;
            std::string s = std::to_string(square);

            if (check(s, i, 0, 0)) {
                total_punishment_sum += square;
            }
        }

        return static_cast<int>(total_punishment_sum);
    }
};