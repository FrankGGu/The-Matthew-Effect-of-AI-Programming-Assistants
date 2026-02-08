#include <string>
#include <numeric>

class Solution {
public:
    int countSymmetricIntegers(int low, int high) {
        int count = 0;
        for (int i = low; i <= high; ++i) {
            std::string s = std::to_string(i);
            int n = s.length();
            if (n % 2 != 0) {
                continue;
            }

            int mid = n / 2;
            int sum1 = 0;
            int sum2 = 0;

            for (int j = 0; j < mid; ++j) {
                sum1 += s[j] - '0';
            }

            for (int j = mid; j < n; ++j) {
                sum2 += s[j] - '0';
            }

            if (sum1 == sum2) {
                count++;
            }
        }
        return count;
    }
};