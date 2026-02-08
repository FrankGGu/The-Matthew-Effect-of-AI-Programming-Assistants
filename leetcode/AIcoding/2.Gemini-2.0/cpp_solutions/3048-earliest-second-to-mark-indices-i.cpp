#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int earliestSecondToMarkIndices(vector<int>& nums, vector<int>& changeIndices) {
        int n = nums.size();
        int m = changeIndices.size();

        auto check = [&](int time) {
            vector<int> last(n + 1, -1);
            for (int i = 0; i < time; ++i) {
                last[changeIndices[i]] = i;
            }

            vector<bool> marked(n + 1, false);
            int markedCount = 0;
            int seconds = 0;

            for (int i = 1; i <= n; ++i) {
                if (last[i] == -1) {
                    return false;
                }
            }

            vector<pair<int, int>> operations;
            for (int i = 1; i <= n; ++i) {
                operations.push_back({last[i], i});
            }

            sort(operations.begin(), operations.end());

            for (auto& op : operations) {
                int index = op.second;
                if (nums[index - 1] == 0) {
                    marked[index] = true;
                    markedCount++;
                    seconds++;
                } else {
                    if (seconds >= nums[index - 1]) {
                        seconds -= nums[index - 1];
                        marked[index] = true;
                        markedCount++;
                        seconds++;
                    } else {
                        seconds = -1;
                        break;
                    }
                }
            }

            if (seconds == -1) return false;

            return markedCount == n;
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