#include <numeric>

class Solution {
public:
    int subtractProductAndSum(int n) {
        int sum = 0;
        int product = 1;
        string s = to_string(n);
        for (char c : s) {
            int digit = c - '0';
            sum += digit;
            product *= digit;
        }
        return product - sum;
    }
};