#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minMoves(vector<int>& nums, int k) {
        vector<int> ones;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == 1) {
                ones.push_back(i);
            }
        }

        int n = ones.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + ones[i];
        }

        int res = INT_MAX;
        for (int i = 0; i <= n - k; ++i) {
            int left = i, right = i + k - 1;
            int mid = (left + right) / 2;
            int radius = mid - left;
            int sum = (prefix[right + 1] - prefix[mid + 1]) - (prefix[mid] - prefix[left]);
            int cost = sum - (radius * (radius + 1));
            if (k % 2 == 0) {
                cost -= ones[mid];
                cost += radius + 1;
            }
            res = min(res, cost);
        }

        return res;
    }
};