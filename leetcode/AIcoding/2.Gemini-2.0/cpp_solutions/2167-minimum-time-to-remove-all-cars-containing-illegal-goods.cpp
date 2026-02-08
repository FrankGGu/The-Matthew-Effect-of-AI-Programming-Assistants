#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumTime(string s) {
        int n = s.size();
        vector<int> left(n + 1, 0);
        vector<int> right(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            left[i] = left[i - 1];
            if (s[i - 1] == '1') {
                left[i] = min(left[i] + 2, i);
            }
        }

        for (int i = n - 1; i >= 0; --i) {
            right[i] = right[i + 1];
            if (s[i] == '1') {
                right[i] = min(right[i] + 2, n - i);
            }
        }

        int ans = n;
        for (int i = 0; i <= n; ++i) {
            ans = min(ans, left[i] + right[i]);
        }

        return ans;
    }
};