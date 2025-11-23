#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxBalancedSubsequenceSum(vector<int>& nums) {
        int n = nums.size();
        vector<int> arr(n);
        for (int i = 0; i < n; ++i) {
            arr[i] = nums[i] - (i + 1);
        }

        vector<int> sortedArr = arr;
        sort(sortedArr.begin(), sortedArr.end());
        map<int, int> compress;
        int idx = 0;
        for (int i = 0; i < n; ++i) {
            if (compress.find(sortedArr[i]) == compress.end()) {
                compress[sortedArr[i]] = ++idx;
            }
        }

        vector<long long> bit(idx + 1, -1e18);

        auto update = [&](int i, long long val) {
            for (; i <= idx; i += i & -i) {
                bit[i] = max(bit[i], val);
            }
        };

        auto query = [&](int i) {
            long long res = -1e18;
            for (; i > 0; i -= i & -i) {
                res = max(res, bit[i]);
            }
            return res;
        };

        long long ans = -1e18;
        for (int i = 0; i < n; ++i) {
            int compressedVal = compress[arr[i]];
            long long currentSum = query(compressedVal - 1) + nums[i];
            currentSum = max((long long)nums[i], currentSum);
            ans = max(ans, currentSum);
            update(compressedVal, currentSum);
        }

        return ans;
    }
};