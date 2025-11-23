#include <string>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::string maximumBinaryString(std::string binary) {
        int n = binary.length();
        int count_0 = 0;
        int first_zero_idx = -1;

        for (int i = 0; i < n; ++i) {
            if (binary[i] == '0') {
                count_0++;
                if (first_zero_idx == -1) {
                    first_zero_idx = i;
                }
            }
        }

        if (count_0 == 0) {
            return binary;
        }

        std::string result(n, '1');
        result[first_zero_idx + (count_0 - 1)] = '0';

        return result;
    }
};