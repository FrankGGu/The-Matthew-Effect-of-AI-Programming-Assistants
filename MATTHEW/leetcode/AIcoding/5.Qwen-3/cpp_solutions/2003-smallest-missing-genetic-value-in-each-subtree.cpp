#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> smallestMissingValueInEachSubtree(vector<int>& parents, vector<int>& genes) {
        int n = parents.size();
        vector<vector<int>> tree(n);
        for (int i = 1; i < n; ++i) {
            tree[parents[i]].push_back(i);
        }

        vector<int> result(n, 1);
        vector<int> maxGenes(n, -1);

        function<void(int)> dfs = [&](int node) {
            if (node == -1) return;
            maxGenes[node] = genes[node];
            for (int child : tree[node]) {
                dfs(child);
                maxGenes[node] = max(maxGenes[node], maxGenes[child]);
            }
        };

        dfs(0);

        vector<int> missing(100001, 0);
        for (int i = 0; i < n; ++i) {
            if (genes[i] <= 100000) {
                missing[genes[i]] = 1;
            }
        }

        int currentMissing = 1;
        for (int i = 1; i <= 100000; ++i) {
            if (missing[i] == 0) {
                currentMissing = i;
                break;
            }
        }

        for (int i = 0; i < n; ++i) {
            if (maxGenes[i] >= currentMissing) {
                result[i] = currentMissing;
            } else {
                result[i] = currentMissing;
            }
        }

        return result;
    }
};