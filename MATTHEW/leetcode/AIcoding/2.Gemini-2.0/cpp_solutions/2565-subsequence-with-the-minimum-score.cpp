#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumScore(string s, string t) {
        int n = s.size();
        int m = t.size();

        vector<int> prefix(m + 1, n);
        vector<int> suffix(m + 1, -1);

        prefix[0] = -1;
        int j = 0;
        for (int i = 0; i < n && j < m; ++i) {
            if (s[i] == t[j]) {
                prefix[++j] = i;
            }
        }

        suffix[m] = n;
        j = m - 1;
        for (int i = n - 1; i >= 0 && j >= 0; --i) {
            if (s[i] == t[j]) {
                suffix[j--] = i;
            }
        }

        int ans = m;
        for (int i = 0; i <= m; ++i) {
            int low = i, high = m;
            int best = -1;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (prefix[i] < suffix[mid]) {
                    best = mid;
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }
            if (best != -1) {
                ans = min(ans, best - i);
            } else {
                ans = min(ans, m - i);
            }
        }

        return ans;
    }
};