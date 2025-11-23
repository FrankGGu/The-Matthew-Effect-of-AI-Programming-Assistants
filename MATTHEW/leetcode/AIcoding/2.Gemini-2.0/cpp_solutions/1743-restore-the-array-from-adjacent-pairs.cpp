#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> restoreArray(vector<vector<int>>& adjacentPairs) {
        unordered_map<int, vector<int>> adj;
        for (auto& pair : adjacentPairs) {
            adj[pair[0]].push_back(pair[1]);
            adj[pair[1]].push_back(pair[0]);
        }

        int start = 0;
        for (auto& [node, neighbors] : adj) {
            if (neighbors.size() == 1) {
                start = node;
                break;
            }
        }

        vector<int> result;
        result.push_back(start);
        unordered_set<int> visited;
        visited.insert(start);

        while (result.size() < adjacentPairs.size() + 1) {
            int curr = result.back();
            for (int neighbor : adj[curr]) {
                if (visited.find(neighbor) == visited.end()) {
                    result.push_back(neighbor);
                    visited.insert(neighbor);
                    break;
                }
            }
        }

        return result;
    }
};