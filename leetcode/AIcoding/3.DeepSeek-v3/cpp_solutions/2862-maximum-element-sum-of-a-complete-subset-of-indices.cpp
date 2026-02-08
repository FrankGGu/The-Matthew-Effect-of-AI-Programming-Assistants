#include <vector>
#include <cmath>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumSum(vector<int>& nums) {
        int n = nums.size();
        long long res = 0;
        unordered_map<int, long long> sumMap;

        for (int i = 1; i <= n; ++i) {
            int s = 1;
            int i_copy = i;
            for (int d = 2; d * d <= i_copy; ++d) {
                if (i_copy % d == 0) {
                    int cnt = 0;
                    while (i_copy % d == 0) {
                        i_copy /= d;
                        cnt++;
                    }
                    if (cnt % 2 == 1) {
                        s *= d;
                    }
                }
            }
            if (i_copy > 1) {
                s *= i_copy;
            }
            sumMap[s] += nums[i - 1];
            res = max(res, sumMap[s]);
        }

        return res;
    }
};