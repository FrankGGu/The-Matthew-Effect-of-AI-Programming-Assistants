#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int earliestSecondToMarkIndices(vector<int>& nums, vector<int>& changeIndices) {
        int n = nums.size();
        int m = changeIndices.size();
        int left = 0, right = m;
        int ans = -1;

        auto isPossible = [&](int s) {
            vector<int> last(n, -1);
            for (int i = 0; i < s; ++i) {
                int idx = changeIndices[i] - 1;
                if (idx >= 0 && idx < n) {
                    last[idx] = i;
                }
            }
            for (int i = 0; i < n; ++i) {
                if (last[i] == -1) return false;
            }
            int marked = 0;
            for (int i = 0; i < s; ++i) {
                int idx = changeIndices[i] - 1;
                if (idx >= 0 && idx < n && last[idx] == i) {
                    if (marked < nums[idx]) {
                        return false;
                    }
                    marked -= nums[idx];
                    ++marked;
                } else {
                    ++marked;
                }
            }
            return true;
        };

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (isPossible(mid)) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }
};