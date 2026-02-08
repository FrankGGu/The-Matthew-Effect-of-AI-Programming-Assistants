#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isPossible(int n, vector<vector<int>>& edges) {
        vector<int> degree(n + 1, 0);
        for (const auto& edge : edges) {
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        vector<int> odd_nodes;
        for (int i = 1; i <= n; ++i) {
            if (degree[i] % 2 != 0) {
                odd_nodes.push_back(i);
            }
        }

        if (odd_nodes.size() == 0) {
            return true;
        } else if (odd_nodes.size() == 2) {
            int u = odd_nodes[0], v = odd_nodes[1];
            for (const auto& edge : edges) {
                if ((edge[0] == u && edge[1] == v) || (edge[0] == v && edge[1] == u)) {
                    return true;
                }
            }
            return true;
        } else if (odd_nodes.size() == 4) {
            int a = odd_nodes[0], b = odd_nodes[1], c = odd_nodes[2], d = odd_nodes[3];
            auto check = [&](int x, int y) {
                for (const auto& edge : edges) {
                    if ((edge[0] == x && edge[1] == y) || (edge[0] == y && edge[1] == x)) {
                        return false;
                    }
                }
                return true;
            };

            int ab = 2, ac = 2, ad = 2;
            for (const auto& edge : edges) {
                if ((edge[0] == a && edge[1] == b) || (edge[0] == b && edge[1] == a)) ab = 0;
                if ((edge[0] == a && edge[1] == c) || (edge[0] == c && edge[1] == a)) ac = 0;
                if ((edge[0] == a && edge[1] == d) || (edge[0] == d && edge[1] == a)) ad = 0;
            }

            if (check(a,b) && check(c,d)) ab = 1;
            if (check(a,c) && check(b,d)) ac = 1;
            if (check(a,d) && check(b,c)) ad = 1;

            if (ab || ac || ad) return true;

            for (int i = 1; i <= n; i++) {
                if (i == a || i == b || i == c || i == d) continue;
                bool ab_ok = true, cd_ok = true;
                for (const auto& edge : edges) {
                    if ((edge[0] == a && edge[1] == i) || (edge[0] == i && edge[1] == a)) ab_ok = false;
                    if ((edge[0] == b && edge[1] == i) || (edge[0] == i && edge[1] == b)) ab_ok = false;
                    if ((edge[0] == c && edge[1] == i) || (edge[0] == i && edge[1] == c)) cd_ok = false;
                    if ((edge[0] == d && edge[1] == i) || (edge[0] == i && edge[1] == d)) cd_ok = false;
                }
                if (ab_ok && cd_ok) return true;
            }

            return false;
        } else {
            return false;
        }
    }
};