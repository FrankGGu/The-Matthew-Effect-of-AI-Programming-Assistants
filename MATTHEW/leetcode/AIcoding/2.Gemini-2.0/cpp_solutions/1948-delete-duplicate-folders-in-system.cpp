#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> deleteDuplicateFolder(vector<vector<string>>& paths) {
        unordered_map<string, vector<pair<string, int>>> adj;
        vector<string> names;
        names.emplace_back("");
        int nextId = 1;

        auto getId = [&](const string& name) {
            for (int i = 0; i < names.size(); ++i) {
                if (names[i] == name) {
                    return i;
                }
            }
            names.push_back(name);
            return nextId++;
        };

        for (const auto& path : paths) {
            int curr = 0;
            for (const string& folder : path) {
                int next = getId(folder);
                adj[to_string(curr)].emplace_back(folder, next);
                curr = next;
            }
        }

        unordered_map<string, vector<int>> signatureMap;
        vector<string> signatures(nextId);
        vector<bool> marked(nextId, false);

        function<string(int)> dfs = [&](int u) {
            string signature = "(";
            sort(adj[to_string(u)].begin(), adj[to_string(u)].end());
            for (const auto& [name, v] : adj[to_string(u)]) {
                signature += name + dfs(v);
            }
            signature += ")";
            signatures[u] = signature;
            signatureMap[signature].push_back(u);
            return signature;
        };

        dfs(0);

        for (const auto& [signature, nodes] : signatureMap) {
            if (nodes.size() > 1) {
                for (int node : nodes) {
                    marked[node] = true;
                }
            }
        }

        vector<vector<string>> result;

        function<void(int, vector<string>)> buildResult = [&](int u, vector<string> currentPath) {
            if (marked[u]) return;
            if (u != 0) result.push_back(currentPath);

            for (const auto& [name, v] : adj[to_string(u)]) {
                vector<string> nextPath = currentPath;
                nextPath.push_back(name);
                buildResult(v, nextPath);
            }
        };

        buildResult(0, {});

        return result;
    }
};