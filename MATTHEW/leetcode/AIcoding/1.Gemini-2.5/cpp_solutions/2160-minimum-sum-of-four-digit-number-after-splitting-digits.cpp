#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int minimumSum(int num) {
        std::vector<int> digits;
        digits.push_back(num % 10);
        num /= 10;
        digits.push_back(num % 10);
        num /= 10;
        digits.push_back(num % 10);
        num /= 10;
        digits.push_back(num % 10);

        std::sort(digits.begin(), digits.end());

        int new1 = digits[0] * 10 + digits[2];
        int new2 = digits[1] * 10 + digits[3];

        return new1 + new2;
    }
};