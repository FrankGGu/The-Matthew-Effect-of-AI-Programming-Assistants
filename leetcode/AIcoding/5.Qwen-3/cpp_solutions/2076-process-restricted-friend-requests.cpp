#include <iostream>
#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> friendRequests(int n, vector<vector<int>>& restrictions, vector<vector<int>>& requests) {
        vector<vector<int>> result;
        vector<int> parent(n);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        void unionSet(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        }

        for (const auto& request : requests) {
            int u = request[0];
            int v = request[1];
            int rootU = find(u);
            int rootV = find(v);
            if (rootU == rootV) {
                result.push_back({u, v});
                continue;
            }

            bool valid = true;
            for (const auto& r : restrictions) {
                int a = r[0];
                int b = r[1];
                int rootA = find(a);
                int rootB = find(b);
                if ((rootA == rootU && rootB == rootV) || (rootA == rootV && rootB == rootU)) {
                    valid = false;
                    break;
                }
            }

            if (valid) {
                result.push_back({u, v});
                unionSet(u, v);
            }
        }

        return result;
    }
};