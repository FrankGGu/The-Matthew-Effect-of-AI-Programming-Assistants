#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int removeBoxes(vector<int>& boxes) {
        int n = boxes.size();
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(n + 1, 0)));
        return helper(boxes, 0, n - 1, 0, dp);
    }

private:
    int helper(vector<int>& boxes, int left, int right, int k, vector<vector<vector<int>>>& dp) {
        if (left > right) return 0;
        if (dp[left][right][k] != 0) return dp[left][right][k];

        int originalK = k;
        while (right > left && boxes[right] == boxes[right - 1]) {
            right--;
            k++;
        }

        int res = helper(boxes, left, right - 1, k + 1, dp);

        for (int i = left; i < right; i++) {
            if (boxes[i] == boxes[right]) {
                res = max(res, helper(boxes, left, i, k + 1, dp) + helper(boxes, i + 1, right - 1, 0, dp));
            }
        }

        dp[left][right][originalK] = res;
        return res;
    }
};