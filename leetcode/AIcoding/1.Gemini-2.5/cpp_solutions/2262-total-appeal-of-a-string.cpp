#include <string>
#include <vector>

class Solution {
public:
    long long appealSum(std::string s) {
        long long total_appeal = 0;
        std::vector<int> last_occurrence(26, -1);
        int n = s.length();

        for (int i = 0; i < n; ++i) {
            int char_idx = s[i] - 'a';
            int prev_idx = last_occurrence[char_idx];

            total_appeal += static_cast<long long>(i - prev_idx) * (n - i);

            last_occurrence[char_idx] = i;
        }

        return total_appeal;
    }
};