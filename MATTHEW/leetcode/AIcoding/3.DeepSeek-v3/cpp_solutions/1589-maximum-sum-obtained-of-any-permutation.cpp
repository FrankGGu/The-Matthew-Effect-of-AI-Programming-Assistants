#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maxSumRangeQuery(vector<int>& nums, vector<vector<int>>& requests) {
        int n = nums.size();
        vector<int> freq(n + 1, 0);

        for (const auto& req : requests) {
            freq[req[0]]++;
            if (req[1] + 1 < n) {
                freq[req[1] + 1]--;
            }
        }

        for (int i = 1; i < n; ++i) {
            freq[i] += freq[i - 1];
        }

        sort(freq.begin(), freq.end() - 1, greater<int>());
        sort(nums.begin(), nums.end(), greater<int>());

        long long res = 0;
        const int mod = 1e9 + 7;

        for (int i = 0; i < n; ++i) {
            res = (res + (long long)nums[i] * freq[i]) % mod;
        }

        return res;
    }
};