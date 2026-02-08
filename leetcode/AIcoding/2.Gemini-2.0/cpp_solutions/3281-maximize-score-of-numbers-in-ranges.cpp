#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxScore(vector<int>& nums, vector<vector<int>>& quantity) {
        int n = nums.size();
        int m = quantity.size();

        vector<int> q;
        for (auto& v : quantity) {
            q.push_back(v[0]);
        }

        vector<vector<long long>> dp(m + 1, vector<long long>(n + 1, -1));

        function<long long(int, int)> solve = [&](int i, int j) {
            if (i == m) {
                return 0LL;
            }

            if (dp[i][j] != -1) {
                return dp[i][j];
            }

            long long res = -1;
            for (int k = 0; k <= n - j; ++k) {
                if (k < q[i]) continue;

                long long sum = 0;
                vector<int> temp;
                for (int l = 0; l < k; ++l) {
                    temp.push_back(nums[j+l]);
                }
                sort(temp.begin(), temp.end());

                for(int l = 0; l < k; ++l){
                  sum += temp[l];
                }

                long long next_score = solve(i + 1, j + k);
                if (next_score != -1) {
                    res = max(res, next_score + sum);
                }
            }

            return dp[i][j] = res;
        };

        return solve(0, 0);
    }
};