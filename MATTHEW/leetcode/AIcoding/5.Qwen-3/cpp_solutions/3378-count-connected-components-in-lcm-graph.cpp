#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>
#include <numeric>
#include <cmath>

using namespace std;

class Solution {
public:
    int countComponents(int n, vector<vector<int>>& edges) {
        vector<int> parent(n);
        for (int i = 0; i < n; ++i) parent[i] = i;

        function<int(int)> find = [&](int x) {
            return parent[x] == x ? x : parent[x] = find(parent[x]);
        };

        function<void(int, int)> unionSet = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) parent[rootY] = rootX;
        };

        for (auto& edge : edges) {
            unionSet(edge[0], edge[1]);
        }

        unordered_map<int, int> rootMap;
        for (int i = 0; i < n; ++i) {
            rootMap[find(i)]++;
        }

        return rootMap.size();
    }
};