#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSumRangeQuery(vector<int>& nums, vector<vector<int>>& requests) {
        int n = nums.size();
        vector<int> count(n, 0);
        for (auto& request : requests) {
            int start = request[0];
            int end = request[1];
            count[start]++;
            if (end + 1 < n) {
                count[end + 1]--;
            }
        }

        for (int i = 1; i < n; i++) {
            count[i] += count[i - 1];
        }

        sort(nums.begin(), nums.end(), greater<int>());
        sort(count.begin(), count.end(), greater<int>());

        long long maxSum = 0;
        long long mod = 1e9 + 7;
        for (int i = 0; i < n; i++) {
            maxSum = (maxSum + (long long)nums[i] * count[i]) % mod;
        }

        return (int)maxSum;
    }
};