#include <string>
#include <vector>

using namespace std;

string minInteger(string num, int k) {
    int n = num.size();
    vector<vector<int>> pos(10);
    for (int i = n - 1; i >= 0; --i) {
        pos[num[i] - '0'].push_back(i);
    }

    string ans = "";
    vector<bool> used(n, false);
    for (int i = 0; i < n; ++i) {
        for (int d = 0; d <= 9; ++d) {
            if (pos[d].empty()) continue;
            int idx = pos[d].back();
            int swaps = 0;
            for (int j = 0; j < idx; ++j) {
                if (used[j]) swaps++;
            }
            int needed = idx - swaps;
            if (needed <= k) {
                k -= needed;
                ans += (char)('0' + d);
                used[idx] = true;
                pos[d].pop_back();
                break;
            }
        }
    }

    return ans;
}