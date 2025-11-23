#include <vector>

class Solution {
public:
    long long getDescentPeriods(std::vector<int>& prices) {
        long long total_periods = 0;
        long long current_length = 0;
        int n = prices.size();

        for (int i = 0; i < n; ++i) {
            if (i == 0 || prices[i] != prices[i-1] - 1) {
                current_length = 1;
            } else {
                current_length++;
            }
            total_periods += current_length;
        }

        return total_periods;
    }
};