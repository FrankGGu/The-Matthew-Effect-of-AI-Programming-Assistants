#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeWin(vector<int>& prizePositions, int k) {
        int n = prizePositions.size();
        int ans = 0;

        for (int i = 0; i < n; ++i) {
            int j = upper_bound(prizePositions.begin(), prizePositions.end(), prizePositions[i] + k) - prizePositions.begin();
            int len1 = j - i;

            int max_len2 = 0;
            for (int l = j; l < n; ++l) {
                int r = upper_bound(prizePositions.begin(), prizePositions.end(), prizePositions[l] + k) - prizePositions.begin();
                max_len2 = max(max_len2, r - l);
            }

            ans = max(ans, len1 + max_len2);
        }

        return ans;
    }
};