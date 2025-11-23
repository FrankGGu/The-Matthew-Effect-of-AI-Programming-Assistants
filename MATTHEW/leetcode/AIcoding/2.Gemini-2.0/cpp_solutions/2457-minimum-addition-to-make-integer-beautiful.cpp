#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long makeIntegerBeautiful(long long n, int target) {
        long long num = n;
        long long pow10 = 1;
        while (true) {
            long long sum = 0;
            long long temp = num;
            while (temp > 0) {
                sum += temp % 10;
                temp /= 10;
            }
            if (sum <= target) {
                return num - n;
            }
            num = (num / pow10 + 1) * pow10;
            pow10 *= 10;
        }
    }
};