#include <iostream>
#include <vector>
#include <cmath>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> cycleLengthQueries(int n, vector<vector<int>>& queries) {
        vector<int> result;
        unordered_map<int, int> depth;
        unordered_map<int, int> parent;

        for (int i = 2; i <= n; ++i) {
            int p = i / 2;
            parent[i] = p;
            depth[i] = depth[p] + 1;
        }

        for (auto& q : queries) {
            int u = q[0];
            int v = q[1];
            int len = 0;
            while (u != v) {
                if (depth[u] > depth[v]) {
                    u = parent[u];
                } else {
                    v = parent[v];
                }
                ++len;
            }
            result.push_back(len + 1);
        }

        return result;
    }
};