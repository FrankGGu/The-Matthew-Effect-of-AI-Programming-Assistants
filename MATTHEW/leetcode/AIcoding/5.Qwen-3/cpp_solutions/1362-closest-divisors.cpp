#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> closestDivisors(long long num) {
        vector<int> res(2);
        for (long long i = sqrt(num) + 1; i >= 1; --i) {
            if (num % i == 0) {
                res[0] = i;
                res[1] = num / i;
                break;
            }
        }
        for (long long i = sqrt(num + 1) + 1; i >= 1; --i) {
            if ((num + 1) % i == 0) {
                if (abs(i - (num + 1) / i) < abs(res[0] - res[1])) {
                    res[0] = i;
                    res[1] = (num + 1) / i;
                }
                break;
            }
        }
        return res;
    }
};