class Solution {
public:
    int kConcatenationMaxSum(vector<int>& arr, int k) {
        long long mod = 1e9 + 7;
        long long totalSum = 0, maxEndingHere = 0, maxSoFar = 0;

        for (int num : arr) {
            totalSum += num;
            maxEndingHere = (maxEndingHere + num) % mod;
            if (maxEndingHere < 0) maxEndingHere = 0;
            maxSoFar = max(maxSoFar, maxEndingHere);
        }

        if (k == 1) return maxSoFar;

        long long result = maxSoFar;
        if (totalSum > 0) {
            result = (result + (totalSum * (k - 2) % mod) + mod) % mod;
            result = (result + max(0LL, totalSum)) % mod;
        }

        return result;
    }
};