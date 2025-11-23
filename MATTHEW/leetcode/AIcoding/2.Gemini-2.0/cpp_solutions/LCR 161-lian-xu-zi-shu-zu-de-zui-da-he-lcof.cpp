#include <vector>

using namespace std;

class Solution {
public:
    vector<int> solve(int k, vector<int>& sales) {
        int n = sales.size();
        vector<int> result;
        if (n < k || k <= 0) {
            return result;
        }

        vector<long long> prefixSum(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            prefixSum[i] = prefixSum[i - 1] + sales[i - 1];
        }

        long long maxSum = prefixSum[k] - prefixSum[0];
        int start = 0;

        for (int i = 1; i <= n - k; ++i) {
            long long currentSum = prefixSum[i + k] - prefixSum[i];
            if (currentSum > maxSum) {
                maxSum = currentSum;
                start = i;
            }
        }

        for (int i = start; i < start + k; ++i) {
            result.push_back(sales[i]);
        }

        return result;
    }
};