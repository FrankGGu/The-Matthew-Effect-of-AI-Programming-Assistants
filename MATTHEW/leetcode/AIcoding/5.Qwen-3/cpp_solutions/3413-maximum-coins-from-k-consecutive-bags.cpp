#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxTotalCoins(int n, vector<int>& bags, int k) {
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + bags[i];
        }

        long long maxCoins = 0;
        for (int i = 0; i <= n - k; ++i) {
            long long sum = prefix[i + k] - prefix[i];
            maxCoins = max(maxCoins, sum);
        }

        return maxCoins;
    }
};