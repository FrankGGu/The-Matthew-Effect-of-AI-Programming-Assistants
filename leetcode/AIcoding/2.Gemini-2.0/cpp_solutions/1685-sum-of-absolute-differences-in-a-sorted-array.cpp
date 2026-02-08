#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> getSumAbsoluteDifferences(vector<int>& nums) {
        int n = nums.size();
        vector<int> result(n);
        vector<long long> prefixSum(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        for (int i = 0; i < n; ++i) {
            long long leftSum = prefixSum[i];
            long long rightSum = prefixSum[n] - prefixSum[i + 1];
            result[i] = (long long)nums[i] * i - leftSum + rightSum - (long long)nums[i] * (n - 1 - i);
        }

        return result;
    }
};