#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int kConcatenationMaxSum(vector<int>& arr, int k) {
        long long MOD = 1e9 + 7;
        long long n = arr.size();
        long long maxSum = 0;
        long long currentSum = 0;

        for (int i = 0; i < n; ++i) {
            currentSum = max((long long)arr[i], currentSum + arr[i]);
            maxSum = max(maxSum, currentSum);
        }

        if (k == 1) {
            return (int)(maxSum % MOD);
        }

        long long totalSum = 0;
        for (int i = 0; i < n; ++i) {
            totalSum += arr[i];
        }

        long long prefixSum = 0;
        long long maxPrefixSum = 0;
        for (int i = 0; i < n; ++i) {
            prefixSum += arr[i];
            maxPrefixSum = max(maxPrefixSum, prefixSum);
        }

        long long suffixSum = 0;
        long long maxSuffixSum = 0;
        for (int i = n - 1; i >= 0; --i) {
            suffixSum += arr[i];
            maxSuffixSum = max(maxSuffixSum, suffixSum);
        }

        if (totalSum > 0) {
            return (int)(max((long long)maxSum, (maxPrefixSum + maxSuffixSum + (k - 2) * totalSum)) % MOD);
        } else {
            return (int)(max((long long)maxSum, (maxPrefixSum + maxSuffixSum)) % MOD);
        }
    }
};