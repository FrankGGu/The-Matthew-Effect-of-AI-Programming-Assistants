#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    int numSimilarGroups(string& s, vector<string>& strs) {
        int n = strs.size();
        vector<int> parent(n);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        auto find = [&](int x) {
            while (parent[x] != x) {
                parent[x] = parent[parent[x]];
                x = parent[x];
            }
            return x;
        };

        auto unite = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        };

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (isSimilar(strs[i], strs[j])) {
                    unite(i, j);
                }
            }
        }

        unordered_set<int> roots;
        for (int i = 0; i < n; ++i) {
            roots.insert(find(i));
        }

        return roots.size();
    }

private:
    bool isSimilar(const string& a, const string& b) {
        int diff = 0;
        for (int i = 0; i < a.size() && diff <= 2; ++i) {
            if (a[i] != b[i]) {
                ++diff;
            }
        }
        return diff == 2;
    }
};