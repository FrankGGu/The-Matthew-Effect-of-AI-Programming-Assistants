#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int concatenatedBinary(int n) {
        long long res = 0;
        long long mod = 1e9 + 7;
        for (int i = 1; i <= n; ++i) {
            int len = 0;
            int temp = i;
            while (temp > 0) {
                len++;
                temp >>= 1;
            }
            res = ((res << len) % mod + i) % mod;
        }
        return (int)res;
    }
};