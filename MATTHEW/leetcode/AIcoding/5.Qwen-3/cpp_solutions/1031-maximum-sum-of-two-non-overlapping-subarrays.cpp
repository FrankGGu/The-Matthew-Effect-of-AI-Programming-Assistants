#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSumTwoNoOverlap(vector<int>& nums, int firstLen, int secondLen) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        auto getSum = [&](int l, int r) {
            return prefix[r] - prefix[l];
        };

        int res = 0;
        for (int i = 0; i <= n - firstLen; ++i) {
            int sum1 = getSum(i, i + firstLen);
            int j = 0;
            while (j <= n - secondLen) {
                if (j + secondLen <= i) {
                    res = max(res, sum1 + getSum(j, j + secondLen));
                } else if (j >= i + firstLen) {
                    res = max(res, sum1 + getSum(j, j + secondLen));
                }
                ++j;
            }
        }

        for (int i = 0; i <= n - secondLen; ++i) {
            int sum2 = getSum(i, i + secondLen);
            int j = 0;
            while (j <= n - firstLen) {
                if (j + firstLen <= i) {
                    res = max(res, sum2 + getSum(j, j + firstLen));
                } else if (j >= i + secondLen) {
                    res = max(res, sum2 + getSum(j, j + firstLen));
                }
                ++j;
            }
        }

        return res;
    }
};