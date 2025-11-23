#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numFactoredBinaryTrees(vector<int>& arr) {
        const int MOD = 1e9 + 7;
        sort(arr.begin(), arr.end());
        unordered_map<int, long> dp;
        for (int num : arr) {
            dp[num] = 1;
        }

        for (int i = 0; i < arr.size(); ++i) {
            for (int j = 0; j < i; ++j) {
                if (arr[i] % arr[j] == 0) {
                    int complement = arr[i] / arr[j];
                    if (dp.find(complement) != dp.end()) {
                        dp[arr[i]] = (dp[arr[i]] + dp[arr[j]] * dp[complement]) % MOD;
                    }
                }
            }
        }

        long result = 0;
        for (auto& [num, count] : dp) {
            result = (result + count) % MOD;
        }
        return result;
    }
};