#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countOrders(int n) {
        long long result = 1;
        for (int i = 2; i <= n; ++i) {
            result = result * (2 * i - 1) * i % 1000000007;
        }
        return static_cast<int>(result);
    }
};