#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSumTwoNoOverlap(vector<int>& nums, int firstLen, int secondLen) {
        int n = nums.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            prefix[i] = prefix[i - 1] + nums[i - 1];
        }

        auto getSum = [&](int left, int right) {
            return prefix[right + 1] - prefix[left];
        };

        int maxScore = 0;

        for (int i = firstLen; i <= n; ++i) {
            int firstMax = getSum(i - firstLen, i - 1);
            for (int j = 0; j <= n - secondLen; ++j) {
                if (j + secondLen <= i - firstLen || j >= i) {
                    maxScore = max(maxScore, firstMax + getSum(j, j + secondLen - 1));
                }
            }
        }

        for (int i = secondLen; i <= n; ++i) {
            int secondMax = getSum(i - secondLen, i - 1);
            for (int j = 0; j <= n - firstLen; ++j) {
                if (j + firstLen <= i - secondLen || j >= i) {
                    maxScore = max(maxScore, secondMax + getSum(j, j + firstLen - 1));
                }
            }
        }

        return maxScore;
    }
};