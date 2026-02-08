#include <vector>

using namespace std;

class Solution {
public:
    vector<bool> areConnected(int n, int threshold, vector<vector<int>>& queries) {
        vector<int> parent(n + 1);
        for (int i = 1; i <= n; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        auto unite = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootX] = rootY;
            }
        };

        for (int i = threshold + 1; i <= n; ++i) {
            for (int j = 2 * i; j <= n; j += i) {
                unite(i, j);
            }
        }

        vector<bool> result;
        for (const auto& query : queries) {
            int a = query[0];
            int b = query[1];
            result.push_back(find(a) == find(b));
        }

        return result;
    }
};