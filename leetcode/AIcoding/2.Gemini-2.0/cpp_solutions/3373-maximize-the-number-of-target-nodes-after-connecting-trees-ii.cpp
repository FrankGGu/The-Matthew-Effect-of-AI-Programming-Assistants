#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int solve(int target, vector<vector<int>>& trees) {
        int n = trees.size();
        vector<int> roots;
        unordered_map<int, int> inDegree;
        for (auto& tree : trees) {
            roots.push_back(tree[0]);
            for (int i = 1; i < tree.size(); ++i) {
                inDegree[tree[i]]++;
            }
        }

        vector<int> rootNodes;
        for (int root : roots) {
            if (inDegree.find(root) == inDegree.end()) {
                rootNodes.push_back(root);
            }
        }

        int ans = 0;
        vector<bool> used(n, false);
        function<void(int, int)> dfs = [&](int curr, int count) {
            ans = max(ans, count);

            for (int i = 0; i < n; ++i) {
                if (!used[i] && trees[i][0] == curr) {
                    used[i] = true;
                    int newCount = count;
                    bool targetFound = false;
                    for (int j = 1; j < trees[i].size(); ++j) {
                        if (trees[i][j] == target) {
                            targetFound = true;
                            break;
                        }
                    }
                    if (targetFound) {
                        newCount++;
                    }
                    dfs(trees[i].back(), newCount);
                    used[i] = false;
                }
            }
        };

        for (int root : rootNodes) {
            for (int i = 0; i < n; ++i) {
                if (!used[i] && trees[i][0] == root) {
                    used[i] = true;
                    int count = 0;
                    bool targetFound = false;
                    for (int j = 1; j < trees[i].size(); ++j) {
                        if (trees[i][j] == target) {
                            targetFound = true;
                            break;
                        }
                    }
                    if (targetFound) {
                        count++;
                    }
                    dfs(trees[i].back(), count);
                    used[i] = false;
                }
            }
        }

        return ans;
    }

    int maximizeTheNumberOfTargetNodes(vector<vector<int>>& trees, int target) {
        return solve(target, trees);
    }
};