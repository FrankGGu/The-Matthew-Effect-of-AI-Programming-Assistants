#include <iostream>
#include <vector>
#include <unordered_map>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> findSubtreeSizes(string s, vector<vector<int>>& queries) {
        int n = s.length();
        vector<int> result;
        vector<int> parent(n, -1);
        vector<vector<int>> children(n);
        for (int i = 0; i < n; ++i) {
            if (s[i] == 'L') {
                parent[i] = i - 1;
                children[i - 1].push_back(i);
            } else if (s[i] == 'R') {
                parent[i] = i - 1;
                children[i - 1].push_back(i);
            }
        }

        vector<int> subtreeSize(n, 1);
        for (int i = n - 1; i >= 0; --i) {
            for (int child : children[i]) {
                subtreeSize[i] += subtreeSize[child];
            }
        }

        for (auto& q : queries) {
            int u = q[0], c = q[1];
            if (u == 0) {
                result.push_back(subtreeSize[u]);
                continue;
            }
            int p = parent[u];
            int originalSize = subtreeSize[p];
            subtreeSize[p] -= subtreeSize[u];
            subtreeSize[u] = 1;
            for (int child : children[u]) {
                subtreeSize[u] += subtreeSize[child];
            }
            result.push_back(subtreeSize[c]);
            subtreeSize[p] = originalSize;
        }

        return result;
    }
};