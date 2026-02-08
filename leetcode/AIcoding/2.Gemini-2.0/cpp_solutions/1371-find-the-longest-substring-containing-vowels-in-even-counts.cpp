#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findTheLongestSubstring(string s) {
        int n = s.length();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i];
            if (s[i] == 'a') prefix[i + 1] ^= (1 << 0);
            if (s[i] == 'e') prefix[i + 1] ^= (1 << 1);
            if (s[i] == 'i') prefix[i + 1] ^= (1 << 2);
            if (s[i] == 'o') prefix[i + 1] ^= (1 << 3);
            if (s[i] == 'u') prefix[i + 1] ^= (1 << 4);
        }

        vector<int> first(32, n + 1);
        first[0] = 0;
        int ans = 0;
        for (int i = 1; i <= n; ++i) {
            if (first[prefix[i]] == n + 1) {
                first[prefix[i]] = i;
            }
            ans = max(ans, i - first[prefix[i]]);
        }

        return ans;
    }
};