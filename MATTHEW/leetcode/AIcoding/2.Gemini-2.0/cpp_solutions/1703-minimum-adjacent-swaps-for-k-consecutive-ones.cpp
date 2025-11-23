#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minMoves(vector<int>& nums, int k) {
        vector<int> ones;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == 1) {
                ones.push_back(i);
            }
        }

        if (k == 1) {
            return 0;
        }

        vector<long long> prefixSum(ones.size() + 1, 0);
        for (int i = 0; i < ones.size(); ++i) {
            prefixSum[i + 1] = prefixSum[i] + ones[i];
        }

        long long ans = LLONG_MAX;
        for (int i = k / 2; i < ones.size() - (k - 1) / 2; ++i) {
            int median = ones[i];
            int leftSize = k / 2;
            int rightSize = k - 1 - leftSize;

            long long leftSum = (long long)median * leftSize - (prefixSum[i] - prefixSum[i - leftSize]);
            long long rightSum = (prefixSum[i + rightSize + 1] - prefixSum[i + 1]) - (long long)median * rightSize;

            long long totalMoves = leftSum + rightSum;

            long long correction = 0;
            for (int j = 1; j <= leftSize; ++j) {
                correction += j;
            }
            for (int j = 1; j <= rightSize; ++j) {
                correction += j;
            }

            ans = min(ans, totalMoves - correction);
        }

        return (int)ans;
    }
};