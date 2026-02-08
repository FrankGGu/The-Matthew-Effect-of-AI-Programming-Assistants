#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<long long> calculateScore(string s, vector<int>& nums) {
        int n = nums.size();
        vector<long long> ans(n);
        vector<bool> used(n, false);
        long long score = 0;

        for (int i = 0; i < n; ++i) {
            if (s[i] == '0') {
                if (!used[i]) {
                    score += nums[i];
                    used[i] = true;
                    if (i > 0 && !used[i - 1]) {
                        used[i - 1] = true;
                    }
                    if (i < n - 1 && !used[i + 1]) {
                        used[i + 1] = true;
                    }
                }
            }
            ans[i] = score;
        }

        return ans;
    }
};