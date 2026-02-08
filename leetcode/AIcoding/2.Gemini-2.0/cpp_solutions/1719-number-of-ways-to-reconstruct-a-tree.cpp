#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int checkWays(vector<vector<int>>& pairs) {
        unordered_map<int, unordered_set<int>> adj;
        unordered_set<int> nodes;
        for (auto& p : pairs) {
            adj[p[0]].insert(p[1]);
            adj[p[1]].insert(p[0]);
            nodes.insert(p[0]);
            nodes.insert(p[1]);
        }

        int root = -1;
        for (int node : nodes) {
            if (adj[node].size() == nodes.size() - 1) {
                root = node;
                break;
            }
        }

        if (root == -1) return 0;

        int count = 1;
        for (int node : nodes) {
            if (node == root) continue;
            int parent = -1;
            int parentSize = nodes.size();
            for (int neighbor : adj[node]) {
                if (adj[neighbor].size() < parentSize && adj[neighbor].size() >= 1) {
                    parent = neighbor;
                    parentSize = adj[neighbor].size();
                }
            }
            if (parent == -1) return 0;
            bool connected = false;
            if (adj[node].count(parent)) connected = true;

            if (!connected) return 0;

            int common = 0;
            for (int neighbor : adj[node]) {
                if (neighbor != parent && neighbor != node && adj[parent].count(neighbor)) {
                    common++;
                }
            }

            if (adj[node].size() == adj[parent].size() - 1) {
                count = 2;
            }
        }

        return count;
    }
};