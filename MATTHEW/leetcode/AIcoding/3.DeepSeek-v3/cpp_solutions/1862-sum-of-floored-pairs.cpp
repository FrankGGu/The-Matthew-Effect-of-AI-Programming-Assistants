#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    int sumOfFlooredPairs(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        int max_num = *max_element(nums.begin(), nums.end());
        vector<int> count(max_num + 2, 0);
        vector<int> prefix(max_num + 2, 0);

        for (int num : nums) {
            count[num]++;
        }

        for (int i = 1; i <= max_num; ++i) {
            prefix[i] = prefix[i - 1] + count[i];
        }

        long long res = 0;
        for (int i = 1; i <= max_num; ++i) {
            if (count[i] == 0) continue;
            for (int j = 1; i * j <= max_num; ++j) {
                int lower = i * j;
                int upper = i * (j + 1) - 1;
                upper = min(upper, max_num);
                int cnt = prefix[upper] - prefix[lower - 1];
                res = (res + (long long)cnt * j * count[i]) % MOD;
            }
        }

        return res;
    }
};