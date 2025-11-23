#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumTime(std::string s) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        std::vector<int> dp_left(n);
        std::vector<int> dp_right(n);

        dp_left[0] = (s[0] == '1' ? 1 : 0);
        for (int i = 1; i < n; ++i) {
            if (s[i] == '0') {
                dp_left[i] = dp_left[i-1];
            } else {
                dp_left[i] = std::min(dp_left[i-1] + 2, i + 1);
            }
        }

        dp_right[n-1] = (s[n-1] == '1' ? 1 : 0);
        for (int i = n - 2; i >= 0; --i) {
            if (s[i] == '0') {
                dp_right[i] = dp_right[i+1];
            } else {
                dp_right[i] = std::min(dp_right[i+1] + 2, n - i);
            }
        }

        int min_total_cost = dp_right[0]; 

        for (int i = 0; i < n; ++i) {
            int current_total_cost = dp_left[i];
            if (i + 1 < n) {
                current_total_cost += dp_right[i+1];
            }
            min_total_cost = std::min(min_total_cost, current_total_cost);
        }

        return min_total_cost;
    }
};