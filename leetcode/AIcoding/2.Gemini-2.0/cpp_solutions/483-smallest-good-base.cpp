#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    string smallestGoodBase(string n) {
        long long num = stoll(n);
        int mmax = floor(log(num) / log(2) + 1);
        for (int m = mmax; m >= 2; m--) {
            long long k = pow(num, 1.0 / (m - 1));
            long long sum = 1, cur = 1;
            for (int i = 1; i < m; i++) {
                if (num / k < cur) {
                    sum = 0;
                    break;
                }
                cur *= k;
                sum += cur;
            }
            if (sum == num) {
                return to_string(k);
            }
            k++;
            sum = 1, cur = 1;
            for (int i = 1; i < m; i++) {
                if (num / k < cur) {
                    sum = 0;
                    break;
                }
                cur *= k;
                sum += cur;
            }
            if (sum == num) {
                return to_string(k);
            }
        }
        return to_string(num - 1);
    }
};