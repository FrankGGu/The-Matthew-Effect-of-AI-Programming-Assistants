class Solution {
public:
    bool isPossible(int n, vector<vector<int>>& edges) {
        vector<unordered_set<int>> adj(n + 1);
        for (auto& e : edges) {
            adj[e[0]].insert(e[1]);
            adj[e[1]].insert(e[0]);
        }

        vector<int> odd;
        for (int i = 1; i <= n; ++i) {
            if (adj[i].size() % 2 != 0) {
                odd.push_back(i);
            }
        }

        if (odd.size() == 0) {
            return true;
        } else if (odd.size() == 2) {
            int a = odd[0], b = odd[1];
            if (!adj[a].count(b)) {
                return true;
            } else {
                for (int i = 1; i <= n; ++i) {
                    if (i != a && i != b && !adj[i].count(a) && !adj[i].count(b)) {
                        return true;
                    }
                }
                return false;
            }
        } else if (odd.size() == 4) {
            int a = odd[0], b = odd[1], c = odd[2], d = odd[3];
            return (!adj[a].count(b) && !adj[c].count(d)) ||
                   (!adj[a].count(c) && !adj[b].count(d)) ||
                   (!adj[a].count(d) && !adj[b].count(c));
        } else {
            return false;
        }
    }
};