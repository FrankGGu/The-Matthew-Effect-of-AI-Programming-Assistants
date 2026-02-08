#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string substrHash(string s, int power, int mod, int k, int hashValue) {
        int n = s.length();
        vector<long long> hash(n, 0);
        vector<long long> powerK(n, 1);

        for (int i = 0; i < n; ++i) {
            hash[i] = (hash[i - 1] * power + s[i]) % mod;
            if (i > 0) powerK[i] = (powerK[i - 1] * power) % mod;
        }

        for (int i = n - k; i >= 0; --i) {
            long long currentHash = (hash[i + k - 1] - hash[i] * powerK[k - 1]) % mod;
            if (currentHash < 0) currentHash += mod;
            if (currentHash == hashValue) {
                return s.substr(i, k);
            }
        }

        return "";
    }
};