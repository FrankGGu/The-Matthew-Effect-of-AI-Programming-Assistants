#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimalKSum(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        long long res = 0;
        int prev = 0;
        for (int num : nums) {
            if (num == prev) continue;
            int cnt = min(num - prev - 1, k);
            if (cnt <= 0) {
                prev = num;
                continue;
            }
            res += (long long)(prev + 1 + prev + cnt) * cnt / 2;
            k -= cnt;
            if (k == 0) break;
            prev = num;
        }
        if (k > 0) {
            res += (long long)(prev + 1 + prev + k) * k / 2;
        }
        return res;
    }
};