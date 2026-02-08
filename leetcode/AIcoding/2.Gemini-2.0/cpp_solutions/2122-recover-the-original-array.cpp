#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> recoverArray(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        for (int i = 1; i < n; ++i) {
            if ((nums[i] - nums[0]) % 2 == 0) {
                int k = (nums[i] - nums[0]) / 2;
                if (k == 0) continue;
                vector<int> lower, upper;
                vector<bool> used(n, false);
                used[0] = true;
                used[i] = true;
                lower.push_back(nums[0] + k);
                int j = 1;
                bool possible = true;
                for (int l = 1; l < n; ++l) {
                    if (used[l]) continue;
                    while (j < n && (used[j] || nums[j] < nums[l] + 2 * k)) {
                        ++j;
                    }
                    if (j == n) {
                        possible = false;
                        break;
                    }
                    lower.push_back(nums[l] + k);
                    used[l] = true;
                    used[j] = true;
                    ++j;
                }
                if (possible) {
                    return lower;
                }
            }
        }
        return {};
    }
};