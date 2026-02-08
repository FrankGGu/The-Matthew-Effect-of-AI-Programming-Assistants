#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int numFactoredBinaryTrees(int n, vector<int>& arr) {
        const int MOD = 1e9 + 7;
        sort(arr.begin(), arr.end());
        map<int, int> indexMap;
        for (int i = 0; i < n; ++i) {
            indexMap[arr[i]] = i;
        }

        vector<int> dp(n, 1);
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (arr[i] % arr[j] == 0) {
                    int complement = arr[i] / arr[j];
                    if (indexMap.find(complement) != indexMap.end()) {
                        int k = indexMap[complement];
                        dp[i] = (dp[i] + dp[j] * dp[k]) % MOD;
                    }
                }
            }
        }

        int result = 0;
        for (int val : dp) {
            result = (result + val) % MOD;
        }
        return result;
    }
};