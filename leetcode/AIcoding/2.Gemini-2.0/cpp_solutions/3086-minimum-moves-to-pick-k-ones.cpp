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

        if (k == 1) return 0;

        vector<long long> preSum(ones.size() + 1, 0);
        for (int i = 0; i < ones.size(); ++i) {
            preSum[i + 1] = preSum[i] + ones[i];
        }

        long long ans = LLONG_MAX;
        for (int i = 0; i <= ones.size() - k; ++i) {
            int mid = i + k / 2;
            long long median = ones[mid];
            long long left = (long long)(mid - i + 1) / 2 * median - (preSum[mid + 1] - preSum[i]);
            long long right = (preSum[i + k] - preSum[mid + 1]) - (long long)(k - (mid - i + 1) / 2) * median;
            ans = min(ans, left + right);
        }

        long long correction = 0;
        for (int i = 0; i < k; ++i) {
            correction += abs(i - k / 2);
        }
        return ans - correction;
    }
};