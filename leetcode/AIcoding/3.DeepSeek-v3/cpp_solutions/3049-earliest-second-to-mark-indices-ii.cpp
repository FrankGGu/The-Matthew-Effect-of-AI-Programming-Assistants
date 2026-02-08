#include <vector>
#include <queue>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int earliestSecondToMarkIndices(vector<int>& nums, vector<int>& changeIndices) {
        int n = nums.size();
        int m = changeIndices.size();
        int left = 0, right = m;
        int answer = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canMarkAll(nums, changeIndices, mid)) {
                answer = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return answer;
    }

private:
    bool canMarkAll(vector<int>& nums, vector<int>& changeIndices, int s) {
        int n = nums.size();
        vector<int> lastOccur(n + 1, -1);
        for (int i = 0; i < s; ++i) {
            lastOccur[changeIndices[i]] = i;
        }

        for (int i = 1; i <= n; ++i) {
            if (lastOccur[i] == -1) {
                return false;
            }
        }

        int marked = 0;
        for (int i = 0; i < s; ++i) {
            int idx = changeIndices[i];
            if (lastOccur[idx] == i) {
                if (nums[idx - 1] > marked) {
                    return false;
                }
                marked -= nums[idx - 1];
                marked++;
            } else {
                marked++;
            }
        }

        return true;
    }
};