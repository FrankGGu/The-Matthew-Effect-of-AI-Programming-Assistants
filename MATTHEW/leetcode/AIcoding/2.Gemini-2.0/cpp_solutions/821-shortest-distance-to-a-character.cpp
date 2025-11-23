#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> shortestToChar(string s, char c) {
        int n = s.length();
        vector<int> ans(n);
        vector<int> pos;
        for (int i = 0; i < n; ++i) {
            if (s[i] == c) {
                pos.push_back(i);
            }
        }

        for (int i = 0; i < n; ++i) {
            int minDist = INT_MAX;
            for (int p : pos) {
                minDist = min(minDist, abs(i - p));
            }
            ans[i] = minDist;
        }

        return ans;
    }
};