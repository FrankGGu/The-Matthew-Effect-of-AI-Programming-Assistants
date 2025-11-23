#include <vector>

using namespace std;

class Solution {
public:
    int unhappyFriends(int n, vector<vector<int>>& preferences, vector<vector<int>>& pairs) {
        vector<vector<int>> pref(n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n - 1; ++j) {
                pref[i][preferences[i][j]] = j;
            }
        }

        vector<int> match(n, 0);
        for (auto& p : pairs) {
            match[p[0]] = p[1];
            match[p[1]] = p[0];
        }

        int count = 0;
        for (int x = 0; x < n; ++x) {
            int y = match[x];
            for (int u : preferences[x]) {
                if (u == y) break;
                int v = match[u];
                if (pref[u][x] < pref[u][v]) {
                    count++;
                    break;
                }
            }
        }
        return count;
    }
};