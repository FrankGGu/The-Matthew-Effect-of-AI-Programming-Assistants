#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int runeReserve(vector<int>& runes) {
        sort(runes.begin(), runes.end());
        int ans = 1;
        int cur = 1;
        for (int i = 1; i < runes.size(); ++i) {
            if (runes[i] == runes[i - 1] + 1) {
                cur++;
            } else {
                cur = 1;
            }
            ans = max(ans, cur);
        }
        return ans;
    }
};