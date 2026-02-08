#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestAwesome(string s) {
        int n = s.size();
        vector<int> seen(1024, n);
        seen[0] = -1;
        int ans = 0;
        int mask = 0;

        for (int i = 0; i < n; ++i) {
            int digit = s[i] - '0';
            mask ^= (1 << digit);

            if (seen[mask] != n) {
                ans = max(ans, i - seen[mask]);
            } else {
                seen[mask] = i;
            }

            for (int j = 0; j < 10; ++j) {
                int tempMask = mask ^ (1 << j);
                if (seen[tempMask] != n) {
                    ans = max(ans, i - seen[tempMask]);
                }
            }
        }

        return ans;
    }
};