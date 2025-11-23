#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int garbageCollection(vector<string>& garbage, vector<int>& travel) {
        int last_m = -1, last_p = -1, last_g = -1;
        int m_count = 0, p_count = 0, g_count = 0;
        int n = garbage.size();
        for (int i = 0; i < n; ++i) {
            for (char c : garbage[i]) {
                if (c == 'M') {
                    m_count++;
                    last_m = i;
                } else if (c == 'P') {
                    p_count++;
                    last_p = i;
                } else {
                    g_count++;
                    last_g = i;
                }
            }
        }
        int ans = m_count + p_count + g_count;
        for (int i = 0; i < travel.size(); ++i) {
            if (i + 1 <= last_m) ans += travel[i];
            if (i + 1 <= last_p) ans += travel[i];
            if (i + 1 <= last_g) ans += travel[i];
        }
        return ans;
    }
};