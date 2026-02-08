#include <vector>
#include <unordered_map>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> analyzeHierarchy(vector<vector<string>>& employees) {
        unordered_map<string, vector<string>> graph;
        unordered_map<string, int> inDegree;
        unordered_set<string> names;

        for (const auto& emp : employees) {
            string name = emp[0];
            string manager = emp[1];
            names.insert(name);
            if (manager != "NULL") {
                graph[manager].push_back(name);
                inDegree[name]++;
                names.insert(manager);
            }
        }

        vector<string> roots;
        for (const auto& name : names) {
            if (inDegree[name] == 0) {
                roots.push_back(name);
            }
        }

        sort(roots.begin(), roots.end());

        vector<vector<string>> result;
        for (const auto& root : roots) {
            vector<string> path;
            dfs(root, graph, path, result);
        }

        return result;
    }

private:
    void dfs(const string& node, unordered_map<string, vector<string>>& graph, vector<string>& path, vector<vector<string>>& result) {
        path.push_back(node);

        if (graph[node].empty()) {
            result.push_back(path);
        } else {
            vector<string> children = graph[node];
            sort(children.begin(), children.end());
            for (const auto& child : children) {
                dfs(child, graph, path, result);
            }
        }

        path.pop_back();
    }
};