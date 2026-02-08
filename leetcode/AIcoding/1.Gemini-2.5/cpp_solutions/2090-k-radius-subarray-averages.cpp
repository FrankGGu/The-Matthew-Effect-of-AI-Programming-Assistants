#include <vector>

using namespace std;

class Solution {
public:
    vector<int> getAverages(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> averages(n, -1);

        if (2 * k + 1 > n) {
            return averages;
        }

        vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        for (int i = k; i < n - k; ++i) {
            long long sum = prefixSum[i + k + 1] - prefixSum[i - k];
            averages[i] = (int)(sum / (2 * k + 1));
        }

        return averages;
    }
};