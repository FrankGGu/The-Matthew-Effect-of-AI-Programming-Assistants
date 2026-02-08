#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string largestNumber(std::string num, std::vector<int>& change) {
        int n = num.length();
        int start_idx = -1;

        for (int i = 0; i < n; ++i) {
            int digit = num[i] - '0';
            if (change[digit] > digit) {
                start_idx = i;
                break;
            }
        }

        if (start_idx == -1) {
            return num;
        }

        for (int i = start_idx; i < n; ++i) {
            int digit = num[i] - '0';
            if (change[digit] >= digit) {
                num[i] = (char)(change[digit] + '0');
            } else {
                break;
            }
        }

        return num;
    }
};