#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int findSubstringInWraproundString(string p) {
        vector<int> dp(26, 0);
        int len = 0;
        for (int i = 0; i < p.length(); i++) {
            if (i > 0 && (p[i] - p[i - 1] == 1 || (p[i - 1] - p[i] == 25))) {
                len++;
            } else {
                len = 1;
            }
            int index = p[i] - 'a';
            dp[index] = max(dp[index], len);
        }
        int sum = 0;
        for (int i = 0; i < 26; i++) {
            sum += dp[i];
        }
        return sum;
    }
};