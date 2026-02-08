#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int earliestSecondToMarkIndices(vector<int>& nums, vector<int>& changeIndices) {
        int n = nums.size();
        int m = changeIndices.size();

        auto check = [&](int time) {
            vector<int> lastOccur(n + 1, -1);
            for (int i = 0; i < time; ++i) {
                lastOccur[changeIndices[i]] = i;
            }

            for (int i = 1; i <= n; ++i) {
                if (lastOccur[i] == -1) {
                    return false;
                }
            }

            vector<bool> marked(n + 1, false);
            int operations = 0;
            for (int i = 0; i < time; ++i) {
                int index = changeIndices[i];
                if (i == lastOccur[index]) {
                    if (nums[index - 1] > operations) {
                        return false;
                    }
                    operations -= nums[index - 1];
                } else {
                    operations++;
                }
            }
            return true;
        };

        int left = 1, right = m;
        int ans = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (check(mid)) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
};