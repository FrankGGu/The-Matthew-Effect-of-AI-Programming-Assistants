#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int n = nums.size();
        long long sum = accumulate(nums.begin(), nums.end(), 0LL);
        if (sum % k == 0) {
            return 0;
        }

        int target = sum % k;
        int ans = n;
        int currentSum = 0;
        unordered_map<int, int> prefixMap;
        prefixMap[0] = -1;

        for (int i = 0; i < n; ++i) {
            currentSum = (currentSum + nums[i]) % k;
            int needed = (currentSum - target + k) % k;

            if (prefixMap.count(needed)) {
                ans = min(ans, i - prefixMap[needed]);
            }
            prefixMap[currentSum] = i;
        }

        return (ans == n) ? -1 : ans;
    }
};