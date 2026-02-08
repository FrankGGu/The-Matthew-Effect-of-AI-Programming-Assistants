#include <iostream>
#include <vector>
#include <unordered_map>
#include <set>

using namespace std;

class Solution {
public:
    int numberOfGoodPaths(vector<int>& nums, vector<int>& edges) {
        int n = nums.size();
        vector<vector<int>> adj(n);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        unordered_map<int, vector<int>> val_nodes;
        for (int i = 0; i < n; ++i) {
            val_nodes[nums[i]].push_back(i);
        }

        vector<int> parent(n);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            return parent[x] == x ? x : parent[x] = find(parent[x]);
        };

        function<void(int, int)> unionSet = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        };

        set<int> sortedVals;
        for (auto& [val, nodes] : val_nodes) {
            sortedVals.insert(val);
        }

        int result = 0;
        for (auto val : sortedVals) {
            for (int node : val_nodes[val]) {
                for (int neighbor : adj[node]) {
                    if (nums[neighbor] <= val) {
                        unionSet(node, neighbor);
                    }
                }
            }

            unordered_map<int, int> rootCount;
            for (int node : val_nodes[val]) {
                int root = find(node);
                rootCount[root]++;
            }

            for (auto& [root, count] : rootCount) {
                result += count * (count - 1) / 2;
            }
        }

        return result;
    }
};