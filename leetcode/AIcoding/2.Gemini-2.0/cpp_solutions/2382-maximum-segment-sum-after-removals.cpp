#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<long long> maximumSegmentSum(vector<int>& nums, vector<int>& removeQueries) {
        int n = nums.size();
        vector<long long> ans(n);
        vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        vector<bool> removed(n, false);
        long long maxSegmentSum = 0;

        for (int i = 0; i < n; ++i) {
            int removeIndex = removeQueries[i];
            removed[removeIndex] = true;

            maxSegmentSum = 0;
            long long currentSegmentSum = 0;
            for (int j = 0; j < n; ++j) {
                if (!removed[j]) {
                    currentSegmentSum += nums[j];
                    maxSegmentSum = max(maxSegmentSum, currentSegmentSum);
                } else {
                    currentSegmentSum = 0;
                }
            }
            ans[i] = maxSegmentSum;
        }

        return ans;
    }
};