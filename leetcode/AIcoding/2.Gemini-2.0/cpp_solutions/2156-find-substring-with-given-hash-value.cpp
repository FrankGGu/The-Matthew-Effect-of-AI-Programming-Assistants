#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string subStrHash(string s, int power, int modulo, int k, int hashValue) {
        int n = s.size();
        long long h = 0;
        long long p = 1;
        for (int i = 0; i < k - 1; ++i) {
            p = (p * power) % modulo;
        }
        int ans = -1;
        for (int i = n - 1; i >= 0; --i) {
            h = (h * power + (s[i] - 'a' + 1)) % modulo;
            if (i + k < n) {
                h = (h - (long long)(s[i + k] - 'a' + 1) * p % modulo + modulo) % modulo;
            }
            if (h == hashValue && i + k <= n) {
                ans = i;
            }
        }
        return s.substr(ans, k);
    }
};