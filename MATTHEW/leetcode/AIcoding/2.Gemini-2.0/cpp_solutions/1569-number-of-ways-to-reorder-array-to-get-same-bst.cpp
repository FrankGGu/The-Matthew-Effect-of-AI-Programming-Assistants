#include <vector>

using namespace std;

class Solution {
public:
    int numWays(vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) return 1;

        vector<vector<long long>> comb(n + 1, vector<long long>(n + 1, 0));
        for (int i = 0; i <= n; ++i) {
            comb[i][0] = comb[i][i] = 1;
            for (int j = 1; j < i; ++j) {
                comb[i][j] = (comb[i - 1][j - 1] + comb[i - 1][j]) % 1000000007;
            }
        }

        function<long long(vector<int>)> solve = [&](vector<int> arr) {
            int m = arr.size();
            if (m <= 1) return 1LL;

            int root = arr[0];
            vector<int> left, right;
            for (int i = 1; i < m; ++i) {
                if (arr[i] < root) {
                    left.push_back(arr[i]);
                } else {
                    right.push_back(arr[i]);
                }
            }

            long long leftWays = solve(left) % 1000000007;
            long long rightWays = solve(right) % 1000000007;

            return (((comb[m - 1][left.size()] % 1000000007) * leftWays) % 1000000007 * rightWays) % 1000000007;
        };

        return (solve(nums) - 1 + 1000000007) % 1000000007;
    }
};